class CategoryProducts {
  final String title;
  final double price;
  final String image;
  final int id;
  final double rating;

  const CategoryProducts({
    required this.title,
    required this.price,
    required this.image,
    required this.id,
    this.rating = 4.5,
  });

  factory CategoryProducts.fromJson(Map<String, dynamic> json) {
    return CategoryProducts(
      title: json['title'] ?? 'Unknown Title', // Add null check
      price: (json['price'] as num?)?.toDouble() ?? 0.0, // Add null check and cast to double
      image: json['image'] ?? 'default_image.png', // Add null check
      id: (json['id'] as num?)?.toInt() ?? 0, // Add null check and cast to int
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5, // Add null check and cast to double
    );
  }
}