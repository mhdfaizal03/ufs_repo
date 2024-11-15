import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ufs_testing/utils/widgets/custom_textfield.dart';
import 'package:ufs_testing/view/screens/detail_screen.dart';
import 'package:ufs_testing/controller/controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  final getController = Get.put(GetXModel());

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product list"),
        centerTitle: true,
      ),
      body: getController.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: Colors.red,
              ),
            )
          : Obx(
              () => ListView.builder(
                  itemCount: getController.itemList.length,
                  itemBuilder: (context, index) {
                    // for use indexed data
                    final indexedData = getController.itemList[index];
                    return Card(
                        child: ListTile(
                      onTap: () {
                        Get.to(DetailScreen(
                          image: indexedData.image.toString(),
                          name: indexedData.name.toString(),
                          description: indexedData.description.toString(),
                          price: indexedData.price.toString(),
                          category: indexedData.category.toString(),
                        ));
                      },
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(indexedData.image.toString()),
                      ),
                      title: Text(
                        indexedData.name.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text('\$ ${indexedData.price.toString()}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                getController.deleteData(
                                    indexedData.id, context);
                              },
                              icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ));
                  }),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          createDataFn(context);
        },
        label: const Text("add data"),
      ),
    );
  }

  // dialog box for creating list

  void createDataFn(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: AlertDialog(
          title: SingleChildScrollView(
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  InkWell(
                    onTap: () => getController.selectImage(context),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: getController.image != null
                          ? FileImage(getController.image!)
                          : const NetworkImage(
                              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fone-person&psig=AOvVaw35QCBELDR3xX_XHsp01x1b&ust=1731739216609000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCPDi2bnd3YkDFQAAAAAdAAAAABAE"),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: "name",
                    controller: nameController,
                    validator: (value) {
                      if (nameController.text.isEmpty) {
                        return "enter a value";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: "description",
                    controller: descriptionController,
                    validator: (value) {
                      if (descriptionController.text.isEmpty) {
                        return "enter a value";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    keyboardType: TextInputType.number,
                    hintText: "price",
                    controller: priceController,
                    validator: (value) {
                      if (priceController.text.isEmpty) {
                        return "enter a value";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: "category",
                    controller: categoryController,
                    validator: (value) {
                      if (categoryController.text.isEmpty) {
                        return "enter a value";
                      } else {
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("cancel")),
            TextButton(
                onPressed: () {
                  if (_globalKey.currentState!.validate()) {
                    Get.back();
                    getController.createData(
                      context,
                      name: nameController.text,
                      price: priceController.text,
                      image: getController.image.toString(),
                      description: descriptionController.text.toString(),
                      category: categoryController.text.toString(),
                      id: 21,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("cant add data")));
                  }
                },
                child: const Text("add data"))
          ],
        ),
      ),
    );
  }

  // dialog box for selection image source from camera/gallery
}
