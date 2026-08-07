import 'package:equatable/equatable.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter.dart';

abstract class ProductFilterEvent extends Equatable {
  const ProductFilterEvent();
  @override
  List<Object?> get props => [];
}

class FetchProductEvent extends ProductFilterEvent {
  final ProductFilter filter;
  const FetchProductEvent({required this.filter});
  @override
  List<Object?> get props => [filter];
}

// class FetchProductsByQueryEvent extends ProductFilterEvent {
//   String query;
//   FetchProductsByQueryEvent({required this.query});
//   @override
//   List<Object?> get props => [query];
// }
