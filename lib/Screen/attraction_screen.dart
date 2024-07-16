import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertest/Controller/attraction_controller.dart';
import 'package:fluttertest/Screen/add_attraction_screen.dart';
import 'package:get/get.dart';

class AttractionScreen extends StatefulWidget {
  const AttractionScreen({super.key});

  @override
  State<AttractionScreen> createState() => _AttractionScreenState();
}

class _AttractionScreenState extends State<AttractionScreen> {
  final AttractionController attractionController=Get.put(AttractionController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    attractionController.fetchAttraction();

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Attraction List'),centerTitle: true,),
      body: GetBuilder<AttractionController>(
          init: AttractionController(),
          builder: (controller) {
            if(controller.isLoading){
              return const Center(child: CupertinoActivityIndicator(),);
            }
             else {
              return ListView.builder(
                  itemCount: controller.attraction.length,
                  itemBuilder: (context, index) {
                    final list= controller.attraction[index];
                    return
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)),
                          height: Get.height*0.15,
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                      width: Get.width*0.4,
                                      height: Get.height,
                                      child: Image.network(list.image,fit: BoxFit.cover,)
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10,),

                              Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        list.name,
                                        // style: kSubtitleTextStyle,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        list.description,
                                        style: const TextStyle(color: Colors.grey),
                                        maxLines: 2,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.pin_drop,color: Colors.red[800],),
                                          Text(list.address),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Expanded(
                                flex: 0,
                                child: PopupMenuButton<int>(
                                  onSelected: (index){
                                    if(index==0){
                                      Get.to(()=> AddAttractionScreen(attractionModel: list));

                                    }
                                    if(index==1){

                                      controller.deleteAttriction(list.id).whenComplete((){
                                        controller.fetchAttraction();
                                      });
                                    }
                                  },itemBuilder: (BuildContext context){
                                  return [
                                    const PopupMenuItem<int>(
                                      value: 0,
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit),
                                          SizedBox(width: 8),
                                          Text('Edit'),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem<int>(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: Colors.red),
                                          SizedBox(width: 8),
                                          Text('Delete',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
                                        ],
                                      ),
                                    ),
                                  ];
                                },icon:  const Icon(Icons.more_vert_outlined),
                                  color: Colors.white,

                                ),)

                            ],
                          ),
                        ),
                      );
                  });

            }


          }
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[800],
        onPressed: (){
        Get.to(()=> const AddAttractionScreen());
        },child: const Icon(Icons.add,color: Colors.white,),),
    );
  }
}
