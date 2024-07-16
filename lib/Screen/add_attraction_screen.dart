import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertest/Controller/attraction_controller.dart';
import 'package:fluttertest/Model/get_attractionModel.dart';
import 'package:fluttertest/Model/social_model.dart';
import 'package:fluttertest/Tab%20Screen/info_screen.dart';
import 'package:fluttertest/Tab%20Screen/price_screen.dart';
import 'package:fluttertest/Tab%20Screen/youtube_screen.dart';
import 'package:get/get.dart';

class AddAttractionScreen extends StatefulWidget {
  final AttractionModel? attractionModel;
  const AddAttractionScreen({super.key, this.attractionModel});

  @override
  State<AddAttractionScreen> createState() => _AddAttractionScreenState();
}

class _AddAttractionScreenState extends State<AddAttractionScreen> {
  final AttractionController attractionController=Get.put(AttractionController());
  bool isOnEditMode = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var attraction = widget.attractionModel;
    if(attraction == null ){
    }else{
      isOnEditMode=true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isOnEditMode ?'Update Attraction':'Add Attraction'),
          centerTitle: true,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.red[800],
            labelColor: Colors.red[800],
            tabs: [
              Tab(
                text: 'Info',
              ),
              Tab(
                text: 'Youtube',
              ),
              Tab(
                text: 'Price',
              ),

            ],
          ),
        ),
        body: Column(children: [
          Expanded(
            child: PageView(
              children: [
                TabBarView(
                  children: [
                    Container(child: InfoScreen(attractionModel: widget.attractionModel,),),
                    Container(child: YoutubeScreen(),),
                    Container(child: PriceScreen(),),
                  ],
                ),
              ],
            ),
          ),
        ],),
      ),
    );
  }
}
