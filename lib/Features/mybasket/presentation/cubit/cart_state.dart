import '../../domain/entities/cart_item.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<CartItem> items;
  final double subtotal;
  final double shipping;
  final double tax;
  final double discount;
  final double total;
  final int totalItems;

  const CartLoaded({
    required this.items,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.discount,
    required this.total,
    required this.totalItems,
  });

  CartLoaded copyWith({
    List<CartItem>? items,
    double? subtotal,
    double? shipping,
    double? tax,
    double? discount,
    double? total,
    int? totalItems,
  }) {
    return CartLoaded(
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      shipping: shipping ?? this.shipping,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      totalItems: totalItems ?? this.totalItems,
    );
  }
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);
}

class CartItemAdded extends CartState {
  final String productName;
  final int quantity;

  const CartItemAdded({
    required this.productName,
    required this.quantity,
  });
}

class CartItemRemoved extends CartState {
  final String productName;

  const CartItemRemoved({required this.productName});
}

class CartItemUpdated extends CartState {
  final String productName;
  final int newQuantity;

  const CartItemUpdated({
    required this.productName,
    required this.newQuantity,
  });
}