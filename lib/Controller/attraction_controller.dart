import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertest/Model/district_model.dart';
import 'package:fluttertest/Model/get_attractionModel.dart';
import 'package:fluttertest/Model/provice_model.dart';
import 'package:fluttertest/Model/social_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AttractionController extends GetxController {
  TextEditingController proviceController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController socialController = TextEditingController();
  final TextEditingController imageController = TextEditingController(text: "");
  final TextEditingController galleryPhotoController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController socialValueController =
      TextEditingController();
  final formkeys = GlobalKey<FormState>();

  List<File> imageFile = [];
  File? singleFile;
  List<Province> provinces = [];
  List<DistrictModel> district = [];
  List<SocialModel> social = [];
  List<AttractionModel> attraction = [];
  Province? selectProvince;
  DistrictModel? selectDistrice;
  var isLoading = false;
  var provinceId=0;
  var districtId=0;
  var socialId=0;

  final String bearerToken =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90ZXN0LXN1cGVyYXBwLWFwaS5pZGV2Lmdyb3VwXC9tb2JpbGVcL2xvZ2luIiwiaWF0IjoxNzE5NDU4MDYzLCJleHAiOjEzMzI4NDg5Mzg0MywibmJmIjoxNzE5NDU4MDYzLCJqdGkiOiJ0RDFQemMzcDZ4eGRtMEkwIiwic3ViIjozOCwicHJ2IjoiMjkyZDI2ZmQ5NzExY2RkNjk2ZWUwNmE5N2NjYjliZmNmN2RlZmUyZSJ9.0R1gV7-ICpt-TgHygJiMxE_r37CtPYXVLZMGbe1Ulqo";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProvince();
    fetchSocialContact();
    fetchAttraction();

  }

  void updateState(bool state) async {
    isLoading = state;
    update();
  }

  void selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      if (singleFile == null) {
        singleFile = File(pickedImage.path);
      } else {
        imageFile.add(File(pickedImage.path));
      }

      update();
    }
  }

  void cameraImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      if (singleFile == null) {
        singleFile = File(pickedImage.path);
      } else {
        imageFile.add(File(pickedImage.path));
      }
      update();
    }
  }
  Future<String> imageFileToBase64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }
  Future<String> imageToBase64(String imageUrl) async {
    try {
      // Fetch the image from URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Convert to base64
        String base64Image = base64Encode(response.bodyBytes);
        return base64Image;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error converting image to base64: $e');
      throw Exception('Failed to convert image to base64');
    }
  }

  Future<void> fetchProvince() async {
    try {
      updateState(true);
      var url = Uri.parse(
          'https://test-superapp-api.idev.group/mobile/get_province_list');

      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );
      if ((response.statusCode == 200)) {
        // If the server returns a 200 OK response, parse the JSON
        var data = jsonDecode(response.body);
        List<dynamic> provinceList = data['data'];
        List<Province> fetchedProvinces =
            provinceList.map((json) => Province.fromJson(json)).toList();
        provinces = fetchedProvinces;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error scenarios here
    } finally {
      updateState(false);
    }
  }

  Future<void> fetchDistrict(int provinceId) async {
    try {
      updateState(true);
      var url = Uri.parse(
          'https://test-superapp-api.idev.group/mobile/get_district_list_by_province');

      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
        body: {
          'province_id': provinceId.toString(),
        },
      );
      if ((response.statusCode == 200)) {
        // If the server returns a 200 OK response, parse the JSON
        var data = jsonDecode(response.body);
        List<dynamic> districList = data['data'];
        List<DistrictModel> fetchedDistrict =
            districList.map((json) => DistrictModel.fromJson(json)).toList();
        district = fetchedDistrict;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      // Handle error scenarios here
    } finally {
      updateState(false);
    }
  }

  Future<void> fetchSocialContact() async {
    try {
      updateState(true);
      var url = Uri.parse(
          'https://test-superapp-api.idev.group/mobile/get_social_contact_list');
      var response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $bearerToken',
        },
      );

      if ((response.statusCode == 200)) {
        var data = jsonDecode(response.body);
        List<dynamic> socialList = data['data'];
        List<SocialModel> fetchedSocial =
            socialList.map((json) => SocialModel.fromJson(json)).toList();
        social = fetchedSocial;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      updateState(false);
    }
  }

  Future<void> fetchAttraction() async {
    try {
      updateState(true);
      var url = Uri.parse(
          'https://test-superapp-api.idev.group/mobile/get_my_attraction');
      var body = jsonEncode({
        "table_size":10,
        'page': 1,
        'filter': {'current_user_id': 38},
      });

      var response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $bearerToken',
            'Content-Type': 'application/json',
          },
          body: body);
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
      if ((response.statusCode == 200)) {
        var data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['data'] != null) {
          List<dynamic> attractionList = data['data']['data'];
          List<AttractionModel> fetchedAttractions = [];

          for (var json in attractionList) {
            try {
              // Ensure that json is not null before parsing
              if (json != null) {
                var attraction = AttractionModel.fromJson(json);
                fetchedAttractions.add(attraction);
              } else {
                print('Null JSON object found in data');
              }
            } catch (e) {
              print('Error parsing attraction JSON: $e');
            }
          }

          attraction.addAll(fetchedAttractions);
        } else {
          print('No valid data found in the response');
        }

      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      updateState(false);
    }
  }

  Future<void> addAttriction() async {
  try {
    updateState(true);
    String image='https://tse3.mm.bing.net/th?id=OIP.0B8FoaGmIdKyEQwRSy26ngHaEK&pid=Api&P=0&h=220';
    List<Map<String, String>> galleryPhotoList = [];

    // Convert singleFile if exists
    if (singleFile != null) {
      String base64Image = await imageFileToBase64(singleFile!);
      galleryPhotoList.add({'image': base64Image});
    }

    // Convert imageFile list
    for (File file in imageFile) {
      String base64Image = await imageFileToBase64(file);
      galleryPhotoList.add({'image': base64Image});
    }
    Map<String, dynamic> placeSocialContact = {
      'type': socialId,
      'value': socialValueController.text,
    };

    var body=jsonEncode({
      'current_user_id': 38,
      'image': image,
      'gallery_photo': galleryPhotoList,
      'name': nameController.text,
      'province_id': provinceId,
      'district_id': districtId,
      'address': addressController.text,
      'status':0,
      'description': descriptionController.text,
      'place_social_contact': [placeSocialContact],


    });
    var url = Uri.parse(
        'https://test-superapp-api.idev.group/mobile/add_attraction');
    var response = await http.post(url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
      body: body,

    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if ((response.statusCode == 200)) {
      var data = jsonDecode(response.body);
      if (data['data'] is List) {
        List<dynamic> attractionList = data['data'];

        List<AttractionModel> fetchedSocial = [];

        for (var json in attractionList) {
          try {
            var business = AttractionModel.fromJson(json);
            fetchedSocial.add(business);
          } catch (e) {
            print('Error parsing attraction JSON: $e');
          }
        }

        // Add fetchedSocial to your existing list or use as needed
        attraction.addAll(fetchedSocial);

      }

    } else {

      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');


  } finally {
    updateState(false);
  }
}

  Future<void> updateAttriction(int attractionId,List<int> galleryPhotoIds) async {
  try {
    updateState(true);
    String image='https://tse3.mm.bing.net/th?id=OIP.0B8FoaGmIdKyEQwRSy26ngHaEK&pid=Api&P=0&h=220';
    String base64Image = await imageToBase64(image);
    List<Map<String, String>> galleryPhotoList = [];


    // Convert singleFile if exists
    if (singleFile != null) {
      String base64Image = await imageFileToBase64(singleFile!);
      galleryPhotoList.add({'image': base64Image});
    }

    // Convert imageFile list
    for (File file in imageFile) {
      String base64Image = await imageFileToBase64(file);
      galleryPhotoList.add({'image': base64Image});
    }
    Map<String, dynamic> placeSocialContact = {
      'type': socialId,
      'value': socialValueController.text,
    };

    var body=jsonEncode({
      'id':attractionId,
      'current_user_id': 38,
      'image': base64Image,
      'old_image':image,
      'gallery_photo': galleryPhotoIds.map((id) => {
        'id': id,
        'image':galleryPhotoList
      }).toList(),
      'name': nameController.text,
      'province_id': provinceId,
      'district_id': districtId,
      'address': addressController.text,
      'status':0,
      'description': descriptionController.text,
      'place_social_contact': [placeSocialContact],


    });
    var url = Uri.parse(
        'https://test-superapp-api.idev.group/mobile/edit_attraction');
    var response = await http.post(url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
      body: body,

    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if ((response.statusCode == 200)) {
      var data = jsonDecode(response.body);
      if (data['data'] is List) {
        List<dynamic> attractionList = data['data'];

        List<AttractionModel> fetchedSocial = [];

        for (var json in attractionList) {
          try {
            var business = AttractionModel.fromJson(json);
            fetchedSocial.add(business);
          } catch (e) {
            print('Error parsing attraction JSON: $e');
          }
        }

        // Add fetchedSocial to your existing list or use as needed
        attraction.addAll(fetchedSocial);
      }

    } else {

      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');


  } finally {
    updateState(false);
  }
}

  Future<void> deleteAttriction(int attractionID) async {
  try {
    var body=jsonEncode({
      'id': attractionID,
      'current_user_id': 38,
    });
    var url = Uri.parse(
        'https://test-superapp-api.idev.group/mobile/delete_attraction');
    var response = await http.post(url,
      headers: {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      },
      body: body,

    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if ((response.statusCode == 200)) {
      var data = jsonDecode(response.body);

      attraction.removeWhere((item) => item.id == attractionID);
    } else {

      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
  }
}
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill somthing';
    }
    return null;
  }
  String? fieldValidator(String? value, String fieldType) {
    switch (fieldType) {
      case 'name':

      case 'province':
      case 'district':
      case 'choose':
        if (value == null || value.isEmpty) {
          return 'Please choose something';
        }
        break;
      case 'address':
      case 'des':
      case 'text':
        if (value == null || value.isEmpty) {
          return 'Please fill something';
        }
        break;
      default:
        return 'Invalid field type';
    }
    return null;
  }


}
