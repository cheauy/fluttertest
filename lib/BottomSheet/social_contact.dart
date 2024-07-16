import 'package:flutter/material.dart';
import 'package:fluttertest/Controller/attraction_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialContact extends StatefulWidget {
  const SocialContact({super.key});

  @override
  State<SocialContact> createState() => _SocialContactState();
}

class _SocialContactState extends State<SocialContact> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GetBuilder<AttractionController>(
            init: AttractionController(),
            builder: (controller) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: Colors.grey,
                      height: 8,
                      width: 50,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        'Province/City',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        'Clear',
                        style: TextStyle(color: Colors.red[800]),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: controller.social.length,
                        itemBuilder: (context, index) {
                          final list = controller.social[index];
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              child: SvgPicture.network(list.image),),
                            title: Text(list.name),
                            onTap: () {
                              controller.socialController.text =
                                  list.name;
                              controller.socialId=list.id;
                              Get.back();

                            },
                          );
                        }),
                  )
                ],
              );
            }),
      ),
    );
  }
}
