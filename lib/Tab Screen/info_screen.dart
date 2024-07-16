import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/BottomSheet/district_bottom.dart';
import 'package:fluttertest/BottomSheet/province_bottom.dart';
import 'package:fluttertest/BottomSheet/social_contact.dart';
import 'package:fluttertest/Controller/attraction_controller.dart';
import 'package:fluttertest/Form/text_form.dart';
import 'package:fluttertest/Model/get_attractionModel.dart';
import 'package:fluttertest/Model/social_model.dart';
import 'package:fluttertest/bottomsheet.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class InfoScreen extends StatefulWidget {
  final AttractionModel? attractionModel;
  const InfoScreen({super.key, required this.attractionModel});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final AttractionController attractionController=Get.put(AttractionController());
  bool isOnEditMode = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var attraction = widget.attractionModel;
    if(attraction == null ){
    }else{
      var provinceNameJson = jsonDecode(attraction.provinceName);
      var latinName = provinceNameJson['latin_name'];
      var disrictceNameJson = jsonDecode(attraction.districtName);
      var latinNames = disrictceNameJson['latin_name'];
      attractionController.fetchDistrict(attraction.provinceId);
      attractionController.nameController.text=attraction.name;
      attractionController.proviceController.text=latinName;
      attractionController.provinceId=attraction.provinceId;
      attractionController.districtId=attraction.districtId;
      attractionController.districtController.text=latinNames;
      attractionController.addressController.text=attraction.address;
      attractionController.descriptionController.text=attraction.description;

      if (attraction.placeSocialContact != null && attraction.placeSocialContact.isNotEmpty) {
        var firstContact = attraction.placeSocialContact[0]; // Assuming you want the first item
        var socialName = getSocialNameFromId(firstContact.type, attractionController.social);
        attractionController.socialController.text = socialName;
        attractionController.socialValueController.text = firstContact.value;
      }


      isOnEditMode=true;

    }
  }

  String getSocialNameFromId(int typeId, List<SocialModel> socialModels) {
    var social = socialModels.firstWhere((element) => element.id == typeId);
    return social != null ? social.name : '';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Container(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.red[800],
                  foregroundColor: Colors.white),
              onPressed: () {
                if(attractionController.formkeys.currentState!.validate()){
                  if(isOnEditMode){
                    List<int> galleryPhotoIds = widget.attractionModel!.galleryPhoto.map((photo) => photo.id).toList();

                    attractionController.updateAttriction(widget.attractionModel!.id,galleryPhotoIds);
                  }else{
                    attractionController.addAttriction().whenComplete((){
                      attractionController.fetchAttraction();
                      Get.back();
                    });;
                  }
                }



              },
              child: Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: GetBuilder<AttractionController>(
                init: AttractionController(),
                builder: (controller) {
                  return Form(
                    key: controller.formkeys,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Photo gallary: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .black, // Ensure the text color matches your design
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Colors.red, // Set the asterisk color to red
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                    controller.singleFile ==null ? GestureDetector(
                          onTap: () {
                            showAlert(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            height: 250,
                            width: double.infinity,
                            child:  Center(
                                    child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: Image.asset(
                                            'assets/images/photo_15068136.png')
                                    ),
                                  ),
                          ),
                        ) :
                        GestureDetector(
                          onTap: () {
                            showAlert(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            height: 250,
                            width: double.infinity,
                            child:
                                 Image.file(
                                    controller.singleFile!,
                                    fit: BoxFit.cover,
                                  )
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 100,
                          child: GridView.builder(
                            itemCount: controller.imageFile.length+1,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                            ),
                            itemBuilder: (context, index) {
                              if (index == controller.imageFile.length) {
                                return GestureDetector(
                                  onTap: ()=> showAlert(context),
                                  child: Container(
                                    color: Colors.grey[300],
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                              return Image.file(
                                controller.imageFile[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                         TextForm(
                           validator: (value) => controller.fieldValidator(value, 'text'),
                          controller: controller.nameController,
                          readonly: false,
                          hint: 'Name',
                          richtext: 'Name: ',
                        ),
                         TextForm(
                           validator: (value) => controller.fieldValidator(value, 'choose'),
                           controller: controller.proviceController,
                          hint: 'Province/City',
                          richtext: 'Province/City: ',
                          icon: Icon(Icons.arrow_drop_down_outlined),
                          readonly: true,
                          onTap: ()=> showProvince(context),

                        ),
                         TextForm(
                           validator: (value) => controller.fieldValidator(value, 'choose'),

                           controller: controller.districtController,
                          readonly: true,
                          hint: 'District',
                          richtext: 'District: ',
                          icon: Icon(Icons.arrow_drop_down_outlined),
                           onTap: ()=> showDistrict(context),
                        ),
                         TextForm(
                             validator: (value) => controller.fieldValidator(value, 'text'),

                             controller: controller.addressController,
                            readonly: false,hint: 'Location', richtext: 'Location: '),
                         TextForm(
                           validator: (value) => controller.fieldValidator(value, 'text'),

                           controller:controller.descriptionController ,
                          readonly: false,
                          hint: 'Description',
                          richtext: 'Description: ',
                          maxline: 5,
                        ),
                      SizedBox(height: 15,),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Social Contact',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors
                                      .black, // Ensure the text color matches your design
                                ),
                              ),
                              TextSpan(
                                text: '*',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red, // Set the asterisk color to red
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) => controller.fieldValidator(value, 'choose'),

                                    controller: controller.socialController,
                                    readOnly: true,
                                    onTap: ()=> showSocialContact(context),
                                    decoration: InputDecoration(
                                      hintText: 'Social Contact',
                                      suffixIcon: Icon(Icons.arrow_drop_down_outlined),
                                      focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          borderSide: BorderSide(color: Colors.amber, width: 2)),
                                      fillColor: Colors.grey.withOpacity(0.2),
                                      filled: true,
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(Radius.circular(10))),
                                    ),
                                  ),

                                  SizedBox(height: 15,),

                                  TextFormField(
                                    validator: (value) => controller.fieldValidator(value, 'text'),

                                    controller: controller.socialValueController,

                                    decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            borderSide: BorderSide(color: Colors.amber, width: 2)),
                                        fillColor: Colors.grey.withOpacity(0.2),
                                        filled: true,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(Radius.circular(10))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              flex: 1,
                                child: CircleAvatar(
                                  backgroundColor: Colors.red[800],
                              radius: 45,
                              child: Icon(Icons.add,color: Colors.white,),))
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}

void showAlert(BuildContext context) {
  final AttractionController attractionController =
      Get.put(AttractionController());
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a picture'),
              onTap: () {
                attractionController.cameraImage();
                Get.back();
              },
            ),
            Divider(height: 1),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Phone Gallery'),
              onTap: () {
                attractionController.selectImage();
                Get.back();
              },
            ),
          ],
        ),
      );
    },
  );
}
void showModel(BuildContext context) {
  showCupertinoModalBottomSheet(
      context: Get.context!,
      builder: (context) => Container(
        height: Get.height * 0.25,
        child: Bottomsheet(),
      ));
}
void showProvince(BuildContext context) {
  showCupertinoModalBottomSheet(
      context: Get.context!,
      builder: (context) => Container(
        height: Get.height * 0.50,
        child: ProvinceBottom(),
      ));
}
void showDistrict(BuildContext context) {
  showCupertinoModalBottomSheet(
      context: Get.context!,
      builder: (context) => Container(
        height: Get.height * 0.50,
        child: DistrictBottom(),
      ));
}
void showSocialContact(BuildContext context) {
  showCupertinoModalBottomSheet(
      context: Get.context!,
      builder: (context) => Container(
        height: Get.height * 0.50,
        child: SocialContact(),
      ));
}
