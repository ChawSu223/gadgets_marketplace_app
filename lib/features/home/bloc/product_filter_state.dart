import 'package:equatable/equatable.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter.dart';

import '../models/product_model.dart';

abstract class ProductFilterState extends Equatable {
  const ProductFilterState();

  @override
  List<Object?> get props => [];
}

class ProductFilterInitialState extends ProductFilterState {}

class ProductFilterLoadingState extends ProductFilterState {}

class ProductFilterSuccessState extends ProductFilterState {
  final List<ProductModel> products;
  final ProductFilter filter;

  const ProductFilterSuccessState(this.products, this.filter);

  @override
  List<Object?> get props => [products, filter];
}

class ProductFilterErrorState extends ProductFilterState {
  final String message;

  const ProductFilterErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
