import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productId;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  final double price;

  CartItemModel({
    required this.id,
    required this.productId,
    this.quantity = 1,
    required this.price,
  });
}
