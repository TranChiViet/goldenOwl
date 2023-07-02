
class ShoeModel {
  late int id;
  late double price;
  late String name;
  late String description;
  late String image;
  late String color;

  ShoeModel({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.image,
    required this.color,
  });


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'image': image,
      'color': color,
    };
  }

  ShoeModel.fromJson(Map<String, dynamic> json) {
      id= json['id'];
      price= json['price'].toDouble();
      name= json['name'];
      description= json['description'];
      image= json['image'];
      color= json['color'];
    
  }
}
