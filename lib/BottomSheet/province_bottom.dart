import 'package:flutter/material.dart';
import 'package:fluttertest/Controller/attraction_controller.dart';
import 'package:get/get.dart';

class ProvinceBottom extends StatelessWidget {
  const ProvinceBottom({super.key});

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
                        itemCount: controller.provinces.length,
                        itemBuilder: (context, index) {
                          final list = controller.provinces[index];
                          return ListTile(
                            title: Text(list.latinName),
                            onTap: () {
                              controller.proviceController.text =
                                  list.latinName;
                              controller.provinceId = list.id;
                              controller.fetchDistrict(list.id);
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
