class UserModel
{
  String? id;
  late String name;
  late String email;
  String? image;

  UserModel({this.id, required this.name, required this.email, this.image});

  UserModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson()
  {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image
    };
  }

}
