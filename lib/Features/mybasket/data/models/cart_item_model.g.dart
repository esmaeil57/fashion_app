// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartItemModelAdapter extends TypeAdapter<CartItemModel> {
  @override
  final int typeId = 0;

  @override
  CartItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemModel(
      productId: fields[0] as String,
      productName: fields[1] as String,
      imageUrl: fields[2] as String,
      price: fields[3] as double,
      salePrice: fields[4] as double?,
      selectedSize: fields[5] as String,
      selectedColor: fields[6] as String,
      quantity: fields[7] as int,
      addedAt: fields[8] as DateTime,
      categoryName: fields[9] as String,
      availableSizes: (fields[10] as List).cast<String>(),
      availableColors: (fields[11] as List).cast<String>(),
      isOnSale: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.imageUrl)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.salePrice)
      ..writeByte(5)
      ..write(obj.selectedSize)
      ..writeByte(6)
      ..write(obj.selectedColor)
      ..writeByte(7)
      ..write(obj.quantity)
      ..writeByte(8)
      ..write(obj.addedAt)
      ..writeByte(9)
      ..write(obj.categoryName)
      ..writeByte(10)
      ..write(obj.availableSizes)
      ..writeByte(11)
      ..write(obj.availableColors)
      ..writeByte(12)
      ..write(obj.isOnSale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
