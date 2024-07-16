// import 'package:fluttertest/BottomSheet/social_contact.dart';
// import 'package:fluttertest/Model/social_model.dart';
//
// class AttractionModel {
//   final int currentUserId;
//   final String image;
//   final List<GalleryPhoto> galleryPhotos;
//   final String name;
//   final int provinceId;
//   final int districtID;
//   final String address;
//   final String description;
//   final List<SocialModel> placeSocialContacts;
//
//   AttractionModel({
//     required this.currentUserId,
//     required this.image,
//     required this.galleryPhotos,
//     required this.name,
//     required this.provinceId,
//     required this.districtID,
//     required this.address,
//     required this.description,
//     required this.placeSocialContacts,
//   });
//
//   factory AttractionModel.fromJson(Map<String, dynamic> json) {
//     return AttractionModel(
//       currentUserId: json['current_user_id'],
//       image: json['image'],
//       galleryPhotos: (json['gallery_photo'] as List).map((e) => GalleryPhoto.fromJson(e)).toList(),
//       name: json['name'],
//       provinceId: json['province_id'],
//       districtID: json['district_id'],
//       address: json['address'],
//       description: json['description'],
//       placeSocialContacts: (json['place_social_contact'] as List).map((e) => SocialModel.fromJson(e)).toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'current_user_id': currentUserId,
//       'image': image,
//       'gallery_photo': galleryPhotos.map((e) => e.toJson()).toList(),
//       'name': name,
//       'province_id': provinceId,
//       'district_id': districtID,
//       'address': address,
//       'description': description,
//       'place_social_contact': placeSocialContacts.map((e) => e.toJson())
//           .toList(),
//     };
//   }
// }
class GalleryPhoto {
  final String image;

  GalleryPhoto({
    required this.image,
  });

  factory GalleryPhoto.fromJson(Map<String, dynamic> json) {
    return GalleryPhoto(
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'image': image,
    };
  }
}

