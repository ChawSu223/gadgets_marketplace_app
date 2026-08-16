import 'package:equatable/equatable.dart';
import 'package:gadgets_marketplace/features/home/models/product_model.dart';

abstract class CartItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartItemEvent {
  final ProductModel productModel;
  final int quantity;

  AddToCartEvent({required this.productModel, required this.quantity});

  @override
  List<Object?> get props => [productModel, quantity];
}

class FetchCartItemsEvent extends CartItemEvent {}

class DeleteCartItemsEvent extends CartItemEvent {
  final int index;
  DeleteCartItemsEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class UpdateQuantityEvent extends CartItemEvent {
  final int index;
  final int qty;
  UpdateQuantityEvent({required this.index, required this.qty});

  @override
  List<Object?> get props => [index, qty];
}

// class ShappingTaxCalculateEvent extends CartItemEvent {
//   ShappingTaxCalculateEvent();

//   @override
//
//   List<Object?> get props => [];
// }
