class Product {
  int id;
  String title;
  double price;
  String description;
  String category;
  String image;
  Map rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory Product.fromMap({required Map data}) {
    return Product(
        id: data['id'],
        title: data['title'],
        price: double.parse(data['price'].toString()),
        description: data['description'],
        category: data['category'],
        image: data['image'],
        rating: data['rating']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'qty': 1,
      'rating': rating
    };
  }
}
