import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/features/cart/bloc/cart_item_event.dart';
import 'package:gadgets_marketplace/features/cart/bloc/cart_item_state.dart';
import 'package:gadgets_marketplace/features/cart/repositories/cart_item_repositories.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  final repo = CartItemRepositories();
  CartItemBloc() : super(CartItemInitialState()) {
    on<AddToCartEvent>(((event, emit) {
      final updatedCartItems = [
        ...state.cartItems,

        {'product': event.productModel, 'quantity': event.quantity},
      ];
      final double subTotal = repo.getSubTotalPrice(updatedCartItems);
      final double shipEstimate = repo.getShippingEstimate(updatedCartItems);

      final double tax = repo.getTaxForCartItems(subTotal);

      emit(
        AddCartItemSuccessState(
          cartItems: updatedCartItems,
          subTotal: subTotal,
          shippingCost: shipEstimate,
          tax: tax,
        ),
      );
    }));

    on<FetchCartItemsEvent>(((event, emit) {
      final double subTotal = repo.getSubTotalPrice(state.cartItems);
      final double shipEstimate = repo.getShippingEstimate(state.cartItems);

      final double tax = repo.getTaxForCartItems(subTotal);

      emit(
        FetchCartItemSuccessState(
          cartItems: state.cartItems,
          subTotal: subTotal,
          shippingCost: shipEstimate,
          tax: tax,
        ),
      );
    }));

    on<DeleteCartItemsEvent>(((event, emit) {
      final updatedCartItems = [...state.cartItems];
      updatedCartItems.removeAt(event.index);

      final double subTotal = repo.getSubTotalPrice(updatedCartItems);
      final double shipEstimate = repo.getShippingEstimate(updatedCartItems);

      final double tax = repo.getTaxForCartItems(subTotal);

      emit(
        DeleteCartItemSuccessState(
          cartItems: updatedCartItems,
          subTotal: subTotal,
          shippingCost: shipEstimate,
          tax: tax,
        ),
      );
    }));
    on<UpdateQuantityEvent>(((event, emit) {
      final updatedCartItems = [...state.cartItems];
      updatedCartItems[event.index] = {
        'product': updatedCartItems[event.index]['product'],
        'quantity': event.qty,
      };
      final double subTotal = repo.getSubTotalPrice(updatedCartItems);
      final double shipEstimate = repo.getShippingEstimate(updatedCartItems);

      final double tax = repo.getTaxForCartItems(subTotal);

      emit(
        UpdatedCartItemSuccessState(
          cartItems: updatedCartItems,
          subTotal: subTotal,
          shippingCost: shipEstimate,
          tax: tax,
        ),
      );
    }));

    // on<ShappingTaxCalculateEvent>(((event, emit) {
    //   final shippEstimate = repo.getShippingEstimate(state.cartItems);
    //   final tax = repo.getTaxForCartItems(state.totalPrice);

    //   emit(
    //     ShippingTaxFinalState(
    //       cartItems: state.cartItems,
    //       totalPrice: state.totalPrice,
    //       shippingCost: shippEstimate,
    //       tax: tax,
    //     ),
    //   );
    // }));
  }
}
