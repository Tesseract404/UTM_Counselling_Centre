class CounsellorModel {
  late final String? id;
  late final String? name;
  late final String? clinic_name;
  late final String? degree;
  late final String? email;
  late final String? password;
  late final String? image;

  CounsellorModel({
    this.id,
    this.name,
    this.clinic_name,
    this.email,
    this.degree,
    this.image,
    this.password
   });

  factory CounsellorModel.fromJson(Map<String, dynamic> json) {
    return CounsellorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      clinic_name: json['clinic_name'] as String,
      email: json['email'] as String,
      degree: json['degree'] as String,
      image: json['image']as String,
      password: json['password']as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "clinic_name": clinic_name,
      "degree": degree,
      "email": email,
      "image": image,
      "password": password,
    };
  }
}
