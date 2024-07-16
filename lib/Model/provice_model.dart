import 'dart:convert';

class Province {
  final int id;
  final String latinName;
  final String localName;
  final String image;

  Province({required this.id , required this.latinName, required this.localName, required this.image});

  factory Province.fromJson(Map<String, dynamic> json) {
    String nameJsonString = json['name'];
    Map<String, dynamic> nameJson = jsonDecode(nameJsonString);

    return Province(
      id: json['id'],
      latinName: nameJson['latin_name'],
      localName: nameJson['local_name'],
      image: json['image'],
    );
  }
}
