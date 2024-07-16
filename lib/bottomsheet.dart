import 'package:flutter/material.dart';
import 'package:fluttertest/Controller/attraction_controller.dart';
import 'package:get/get.dart';

class Bottomsheet extends StatelessWidget {
  const Bottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    final AttractionController attractionController=Get.put(AttractionController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: Colors.grey,
                height: 8,
                width: 50,
              ),
            ),
            SizedBox( height: 15),
            Container(
                height: 50,
                width: Get.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.red[800],
                        foregroundColor: Colors.white),
                    
                    onPressed: () {
                      attractionController.selectImage();
                      Get.back();
                    },
                    child: Text('Replace'))),
            SizedBox( height: 15),
            Container(
                height: 50,
                width: Get.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.red[800],
                        foregroundColor: Colors.white),

                    onPressed: () {},
                    child: Text('Remove'))),
            SizedBox( height: 15),
            Container(
                height: 50,
                width: Get.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.red[800],
                        foregroundColor: Colors.white),

                    onPressed: () {},
                    child: Text('View')))
          ],
        ),
      ),
    );
  }
}
