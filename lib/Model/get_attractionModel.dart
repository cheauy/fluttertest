class BusinessListModel {
  final Pagination pagination;
  final List<AttractionModel> data;

  BusinessListModel({
    required this.pagination,
    required this.data,
  });

  factory BusinessListModel.fromJson(Map<String, dynamic> json) {
    return BusinessListModel(
      pagination: Pagination.fromJson(json['pagination']),
      data: List<AttractionModel>.from(json['data'].map((x) => AttractionModel.fromJson(x))),
    );
  }
}

class Pagination {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final int from;
  final int to;

  Pagination({
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.lastPage,
    required this.from,
    required this.to,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      total: json['total'],
      perPage: json['per_page'],
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      from: json['from'],
      to: json['to'],
    );
  }
}

class AttractionModel {
  final int id;
  final int businessTypeId;
  final int contactId;
  final String contactName;
  final int provinceId;
  final String provinceName;
  final int districtId;
  final String districtName;
  final String name;
  final String image;
  final String address;
  final int viewCount;
  final int status;
  final int verify;
  final DateTime createdAt;
  final String description;
  final String isFavorite;
  final List<GalleryPhoto> galleryPhoto;
  final List<PlaceSocialContact> placeSocialContact;


  AttractionModel({
    required this.id,
    required this.businessTypeId,
    required this.contactId,
    required this.contactName,
    required this.provinceId,
    required this.provinceName,
    required this.districtId,
    required this.districtName,
    required this.name,
    required this.image,

    required this.address,
    required this.viewCount,
    required this.status,
    required this.verify,
    required this.createdAt,
    required this.description,
    required this.isFavorite,
    required this.galleryPhoto,
    required this.placeSocialContact,

  });

  factory AttractionModel.fromJson(Map<String, dynamic> json) {
    return AttractionModel(
      id: json['id'],
      businessTypeId: json['business_type_id'],
      contactId: json['contact_id'],
      contactName: json['contact_name'],
      provinceId: json['province_id'],
      provinceName: json['province_name'],
      districtId: json['district_id'],
      districtName: json['district_name'],
      name: json['name'],
      image: "https://test-superapp-api.idev.group/images/attraction/thumbnail/${json['image']}",
      address: json['address'],
      viewCount: json['view_count'],
      status: json['status'],
      verify: json['verify'],
      createdAt: DateTime.parse(json['created_at']),
      description: json['description'],
      isFavorite: json['is_favorite'],
      galleryPhoto: List<GalleryPhoto>.from(json['gallery_photo'].map((x) => GalleryPhoto.fromJson(x))),
      placeSocialContact: List<PlaceSocialContact>.from(json['place_social_contact'].map((x) => PlaceSocialContact.fromJson(x))),

    );
  }
}

class GalleryPhoto {
  final int id;
  final String image;
  final int type;
  final int typeId;
  final int order;
  final DateTime createdAt;
  final DateTime updatedAt;

  GalleryPhoto({
    required this.id,
    required this.image,
    required this.type,
    required this.typeId,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GalleryPhoto.fromJson(Map<String, dynamic> json) {
    return GalleryPhoto(
      id: json['id'],
      image: "https://test-superapp-api.idev.group/images/attraction/thumbnail/attraction/gallery/${json['image']}",
      type: json['type'],
      typeId: json['type_id'],
      order: json['order'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class PlaceSocialContact {
  final int? id;
  final int? businessId;
  final int type;
  final String value;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PlaceSocialContact({
     this.id,
     this.businessId,
    required this.type,
    required this.value,
     this.createdAt,
     this.updatedAt,
  });

  factory PlaceSocialContact.fromJson(Map<String, dynamic> json) {
    return PlaceSocialContact(
      id: json['id'],
      businessId: json['business_id'],
      type: json['type'],
      value: json['value'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
