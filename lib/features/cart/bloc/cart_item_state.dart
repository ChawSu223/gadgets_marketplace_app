import 'package:equatable/equatable.dart';

abstract class CartItemState extends Equatable {
  final List<Map<String, dynamic>> cartItems;
  final double subTotal;
  final double? shippingCost;
  final double? tax;
  const CartItemState({
    required this.cartItems,
    required this.subTotal,
    this.shippingCost,
    this.tax,
  });
  @override
  List<Object?> get props => [cartItems, subTotal, shippingCost, tax];
}

class CartItemInitialState extends CartItemState {
  CartItemInitialState() : super(cartItems: [], subTotal: 0);
}

class FetchCartItemSuccessState extends CartItemState {
  const FetchCartItemSuccessState({
    required super.cartItems,
    required super.subTotal,
    super.shippingCost,
    super.tax,
  });
}

class AddCartItemSuccessState extends CartItemState {
  const AddCartItemSuccessState({
    required super.cartItems,
    required super.subTotal,
    super.shippingCost,
    super.tax,
  });
}

class DeleteCartItemSuccessState extends CartItemState {
  const DeleteCartItemSuccessState({
    required super.cartItems,
    required super.subTotal,
    super.shippingCost,
    super.tax,
  });
}

class UpdatedCartItemSuccessState extends CartItemState {
  const UpdatedCartItemSuccessState({
    required super.cartItems,
    required super.subTotal,
    required super.shippingCost,
    required super.tax,
  });
}

// class ShippingTaxFinalState extends CartItemState {
//   @override
//   final double shippingCost;
//   @override
//   final double tax;
//   const ShippingTaxFinalState({
//     required super.cartItems,
//     required super.subTotal,
//     required this.shippingCost,
//     required this.tax,
//   });
// }
