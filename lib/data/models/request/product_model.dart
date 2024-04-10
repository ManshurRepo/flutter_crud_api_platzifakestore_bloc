import 'dart:convert';

class ProductModel {
  String? title;
  int? price;
  String? description;
  int? categoryId;
  List<String>? images;

  // URL default untuk gambar
  static const String defaultImageUrl = 'https://i.pravatar.cc/300';

  ProductModel({
    this.title,
    this.price,
    this.description,
    this.categoryId = 1,
    List<String>? images,
  }) : images =
            images ?? [defaultImageUrl]; // Menggunakan nilai default jika null

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) =>
      ProductModel(
        title: json["title"],
        price: json["price"],
        description: json["description"],
        categoryId: json["categoryId"],
        images: json["images"] == null
            ? [defaultImageUrl]
            : List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "price": price,
        "description": description,
        "categoryId": categoryId,
        "images": images == null
            ? [defaultImageUrl]
            : List<dynamic>.from(images!.map((x) => x)),
      };
}

// import 'dart:convert';

// class ProductModel {
//   final String title;
//   final int price; // Update tipe data price menjadi int
//   final String description;
//   final String categoryId;
//   final List<String> image;
//   ProductModel({
//     required this.title,
//     required this.price,
//     required this.description,
//     this.categoryId = '1',
//     this.image = const ["https://i.pravatar.cc/300"],
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'title': title,
//       'price': price.toString(), // Konversi int menjadi String sebelum disimpan
//       'description': description,
//       'categoryId': categoryId,
//       'image': image,
//     };
//   }

//   factory ProductModel.fromMap(Map<String, dynamic> map) {
//     return ProductModel(
//       title: map['title'] as String,
//       price: int.parse(
//           map['price'] as String), // Konversi String menjadi int saat dibaca
//       description: map['description'] as String,
//       categoryId: map['categoryId'] as String,
//       image: List<String>.from(
//         (map['image'] as List<String>),
//       ),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory ProductModel.fromJson(String source) =>
//       ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
