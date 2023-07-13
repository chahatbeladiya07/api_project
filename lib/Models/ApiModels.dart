class UserModel {
  int id;
  String name,email,mobile_number;
  String? image,address;
  int? age;

  UserModel({required this.id,
    required this.name,
    required this.mobile_number,
    required this.email,
    this.image,
    this.address,
    this.age
  });
  factory UserModel.fromJson(json){
    return UserModel(
        id: json["id"],
        name: json["name"],
        mobile_number: json["mobile_number"],
        email: json["email"],
      age: json["age"],
      image: json["image"],
      address: json["address"],
    );
  }
}