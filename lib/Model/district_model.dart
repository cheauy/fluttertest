import 'dart:convert';

class DistrictModel {
  final int id;
  final String latinName;
  final String localName;

  DistrictModel({
    required this.id,
    required this.latinName,
    required this.localName,
  });

  factory DistrictModel.fromJson(Map<String, dynamic> json) {
    // Extract the name object and parse its JSON content
    var nameObject = json['name'];
    var nameJson = jsonDecode(nameObject);

    return DistrictModel(
      id: json['id'],
      latinName: nameJson['latin_name'],
      localName: nameJson['local_name'],
    );
  }
}
