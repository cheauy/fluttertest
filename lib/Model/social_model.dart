class SocialModel {
  final int id;
  final String name;
  final String image;

  SocialModel({
    required this.id,
    required this.name,
    required this.image,
  });

  factory SocialModel.fromJson(Map<String, dynamic> json) {
    return SocialModel(
      id: json['id'],
      name: json['name'],
      image: 'https://test-superapp-api.idev.group/images/attraction/social_contact/${json['image']}',

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image':image
    };
  }
}
