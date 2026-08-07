import 'package:equatable/equatable.dart';

class ProductFilter extends Equatable {
  final String category;
  final String keyword;

  const ProductFilter({this.category = "All", this.keyword = ""});

  ProductFilter copyWith(String? category, String? keyword) {
    return ProductFilter(
      category: category ?? this.category,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [category, keyword];
}
