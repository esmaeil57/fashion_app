import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addToCart(CartItemModel item);
  Future<void> updateCartItem(CartItemModel item);
  Future<void> removeFromCart(String productId, String size, String color);
  Future<void> clearCart();
  Stream<List<CartItemModel>> watchCartItems();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  static const String _boxName = 'cart_items';
  late Box<CartItemModel> _box;

  CartLocalDataSourceImpl();

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox<CartItemModel>(_boxName);
    } else {
      _box = Hive.box<CartItemModel>(_boxName);
    }
  }

  String _generateKey(String productId, String size, String color) {
    return '${productId}_${size}_$color';
  }

  @override
  Future<List<CartItemModel>> getCartItems() async {
    await init();
    return _box.values.toList();
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    await init();
    final key = _generateKey(item.productId, item.selectedSize, item.selectedColor);
    
    // Check if item with same product, size, and color already exists
    final existingItem = _box.get(key);
    if (existingItem != null) {
      // Update quantity instead of adding new item
      final updatedItem = existingItem.copyWith(
        quantity: existingItem.quantity + item.quantity,
      );
      await _box.put(key, updatedItem);
    } else {
      await _box.put(key, item);
    }
  }

  @override
  Future<void> updateCartItem(CartItemModel item) async {
    await init();
    final key = _generateKey(item.productId, item.selectedSize, item.selectedColor);
    await _box.put(key, item);
  }

  @override
  Future<void> removeFromCart(String productId, String size, String color) async {
    await init();
    final key = _generateKey(productId, size, color);
    await _box.delete(key);
  }

  @override
  Future<void> clearCart() async {
    await init();
    await _box.clear();
  }

  @override
  Stream<List<CartItemModel>> watchCartItems() {
    return _box.watch().map((_) => _box.values.toList());
  }
}