
import 'dart:convert';

class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;
  final String description;
  final double rating;

  const Product({
   required this.id,
   required this.title,
   required this.price,
   required this.image,
   required this.category,
   required this.description,
   required this.rating,
});

  //--------fromMap [ Map --> Product ]
  factory Product.fromMap(Map<String, dynamic> map){
    return Product(
        id: map['id'],
        title: map['title'],
        price: map['price'],
        image: map['thumbnail'],
        category: map['category'],
        description: map['description'],
        rating: map['rating'],
    );
  }

  //-----toMap [ Product --> Map ]
Map<String, dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'price':price,
      'image':image,
      'category':category,
      'description':description,
      'rating':rating,
    };
}

//---Data Send-->Encode----- toJson [ Product --> JSON String ]
String toJson(){
    return json.encode(toMap());
}

//--Data Get-->DECODE---- fromJson [JSON String --> Product ]
factory Product.fromJson(String source){
    return Product.fromMap(
    json.decode(source) as Map<String, dynamic>,
    );
}

Product copyWith({
  int? id,
  String? title,
  double? price,
  String? image,
  String? category,
  String? description,
  double? rating,
}){
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      description: description ?? this.description,
      rating: rating ?? this.rating,
    );
}

}


