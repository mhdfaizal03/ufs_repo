import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String image;
  final String name;
  final String description;
  final dynamic price;
  final dynamic category;
  const DetailScreen({
    super.key,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Details Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(category),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(image),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '\$ $price',
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  description,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
