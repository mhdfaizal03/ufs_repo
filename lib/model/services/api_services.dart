import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ufs_testing/model/models/item_model.dart';

class ApiServices {
  var url = "https://fakestoreapi.com";

  // use to fetch data

  Future<List<ItemModel>?> fetchDataFromApi() async {
    var response = await http.get(Uri.parse('$url/products'));

    try {
      if (response.statusCode == 200) {
        var decodedBody = json.decode(response.body);

        List<ItemModel> model = [];

        for (var data in decodedBody) {
          model.add(ItemModel.fromJson(data));
        }

        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // use to create data to Api

  Future<ItemModel?>? createDataToApi(BuildContext context,
      {required String? name,
      required double price,
      required String? image,
      required String? description,
      required String? category,
      required int id}) async {
    var response = await http.post(Uri.parse('$url/products'), body: {
      "title": name,
      "image": image,
      "price": price,
      "description": description,
      "category": category,
      "id": id,
    });

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("deleted data Successfully")));

        var decodedBody = json.decode(response.body);

        return ItemModel.fromJson(decodedBody as Map<String, dynamic>);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // use to delete data from Api
  Future<ItemModel?> deleteDataFromApi(int? id, BuildContext context) async {
    var response = await http.delete(Uri.parse('$url/products/$id'));

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("deleted data Successfully")));
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
