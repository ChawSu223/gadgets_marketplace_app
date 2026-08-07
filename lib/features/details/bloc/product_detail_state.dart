import 'package:equatable/equatable.dart';
import 'package:gadgets_marketplace/features/home/models/product_model.dart';

abstract class ProductDetailState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailSuccessState extends ProductDetailState {
  final ProductModel product;
  ProductDetailSuccessState({required this.product});
  @override
  // TODO: implement props
  List<Object?> get props => [product];
}

class ProductDetailErrorState extends ProductDetailState {
  final String message;
  ProductDetailErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
