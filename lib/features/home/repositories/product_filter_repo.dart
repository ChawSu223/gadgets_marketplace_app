import 'package:gadgets_marketplace/core/constants/supabase_client.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter.dart';

abstract class ProductFilterRepo {
  Future<List<dynamic>> fetchProductsByFilter(ProductFilter filter);
}

class ProductFilterRepositories extends ProductFilterRepo {
  @override
  Future<List<dynamic>> fetchProductsByFilter(ProductFilter filter) async {
    var query = supabase.from('products').select();

    if (filter.category.isNotEmpty && filter.category != 'All') {
      query = query.eq('category', filter.category);
    }

    if (filter.keyword.isNotEmpty) {
      query = query.or(
        'name.ilike.%${filter.keyword}%, category.ilike.%${filter.keyword}',
      );
    }

    return query;
  }
}
