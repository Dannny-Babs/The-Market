class CategoryProducts {
  final String title;
  final int price;
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
      title: json['title'],
      price: json['price'],
      image: json['image'],
      id: json['id'],
      rating: json['rating'],
    );
  }
}