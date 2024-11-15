import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ufs_testing/model/models/item_model.dart';
import 'package:ufs_testing/model/services/api_services.dart';

class GetXModel extends GetxController {
  var itemList = <ItemModel>[].obs;
  bool isLoading = false;
  File? image;

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  // get data from api

  void getData() async {
    isLoading = true;
    try {
      var data = await ApiServices().fetchDataFromApi();
      if (data != null) {
        isLoading = false;
        itemList.value = data;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // create data to api

  void createData(BuildContext context,
      {required String name,
      required dynamic price,
      required String image,
      required String category,
      required String description,
      required int id}) async {
    try {
      var data = await ApiServices().createDataToApi(context,
          name: name,
          price: price,
          image: image,
          category: category,
          description: description,
          id: id);
      if (data != null) {
        itemList.add(data);
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error : ${e.toString()}")));
    }
  }

  //delete data from api

  void deleteData(int? id, BuildContext context) {
    isLoading = false;
    try {
      var data = ApiServices().deleteDataFromApi(id, context);
      itemList.remove(data);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // image source to pick image

  void pickImage(ImageSource source) async {
    final picker = await ImagePicker().pickImage(source: source);

    try {
      if (picker != null) {
        Get.back();
        image = File(picker.path);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  // platform for getting image from gallery/camera

  void selectImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                children: [
                  InkWell(
                    onTap: () => pickImage(ImageSource.camera),
                    child: const ListTile(
                      leading: Icon(Icons.camera),
                      title: Text("camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () => pickImage(ImageSource.gallery),
                    child: const ListTile(
                      leading: Icon(Icons.browse_gallery),
                      title: Text("gallery"),
                    ),
                  )
                ],
              ),
            ));
  }
}
