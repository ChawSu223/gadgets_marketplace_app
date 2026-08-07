import 'package:gadgets_marketplace/features/home/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailRepositories {
  final SupabaseClient supabase;
  ProductDetailRepositories({required this.supabase});

  Future<ProductModel> fetchProductById(String id) async {
    final query = await supabase
        .from('products')
        .select()
        .eq('id', id)
        .single();
    return ProductModel.fromJson(query);
  }
}
