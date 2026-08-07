import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/features/home/models/product_model.dart';
import 'package:gadgets_marketplace/features/home/repositories/product_filter_repo.dart';

import 'product_filter_event.dart';
import 'product_filter_state.dart';

class ProductFilterBloc extends Bloc<ProductFilterEvent, ProductFilterState> {
  ProductFilterBloc() : super(ProductFilterInitialState()) {
    on<FetchProductEvent>((event, emit) async {
      emit(ProductFilterLoadingState());
      try {
        List<dynamic> response = await ProductFilterRepositories()
            .fetchProductsByFilter(event.filter);

        List<ProductModel> filteredProducts = response
            .map((e) => ProductModel.fromJson(e))
            .toList();
        emit(ProductFilterSuccessState(filteredProducts, event.filter));
      } catch (e) {
        emit(ProductFilterErrorState('Failed to load products: $e'));
      }
    });
  }
}
