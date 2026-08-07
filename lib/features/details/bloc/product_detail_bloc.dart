import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/features/details/bloc/product_detail_event.dart';
import 'package:gadgets_marketplace/features/details/bloc/product_detail_state.dart';
import 'package:gadgets_marketplace/features/details/repositories/product_detail_repositories.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductDetailRepositories repo;
  ProductDetailBloc({required this.repo}) : super(ProductDetailInitialState()) {
    on<FetchProductByIdEvent>((event, emit) async {
      emit(ProductDetailLoadingState());
      try {
        final product = await repo.fetchProductById(event.id);
        emit(ProductDetailSuccessState(product: product));
      } catch (e) {
        emit(ProductDetailErrorState(message: e.toString()));
      }
    });
  }
}
