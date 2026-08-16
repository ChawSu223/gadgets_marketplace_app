class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final Map<String, dynamic> specs;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.specs,
  });

  // Supabase JSON response မှ Dart Object သို့ ပြောင်းရန်
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] as String? ?? '',
      category: json['category'] as String? ?? '',
      specs: json['specs'] as Map<String, dynamic>? ?? {'': ''},
    );
  }

  // Dart Object မှ JSON သို့ ပြောင်းရန် (အသုံးပြုလိုပါက)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'category': category,
      'specs': specs,
    };
  }
}
