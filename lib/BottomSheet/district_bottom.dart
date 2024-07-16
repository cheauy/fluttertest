import 'package:flutter/material.dart';
import 'package:fluttertest/Controller/attraction_controller.dart';
import 'package:get/get.dart';

class DistrictBottom extends StatelessWidget {
  const DistrictBottom({super.key});

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
                        'District',
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
                        itemCount: controller.district.length,
                        itemBuilder: (context, index) {
                          final list = controller.district[index];
                          return ListTile(
                            title: Text(list.latinName),
                            onTap: () {
                              controller.districtController.text =
                                  list.latinName;
                              controller.districtId=list.id;
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
