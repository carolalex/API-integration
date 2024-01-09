import 'package:flutter/material.dart';
import 'model.dart';
import 'provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: camel_case_types
class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

// ignore: camel_case_types
class _Home_PageState extends State<Home_Page> {
  late Future<List<CategoryModel>> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = CategoryProvider().fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
        title: const Text("Departmental Store"),
      ),
      body: Center(
        child: FutureBuilder<List<CategoryModel>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("Name: ${snapshot.data![index].displayName}"),
                    leading: CachedNetworkImage(
                      imageUrl: snapshot.data![index].displayImage,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubTypeScreen(
                            subCategories: snapshot.data![index].subCategory,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class SubTypeScreen extends StatelessWidget {
  final List<SubCategoryModel> subCategories;

  const SubTypeScreen({Key? key, required this.subCategories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Types"),
      ),
      body: ListView.builder(
        itemCount: subCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("Sub Type: ${subCategories[index].displayName}"),
            leading: CachedNetworkImage(
              imageUrl: subCategories[index].displayImage,
              placeholder: (context, url) => CircularProgressIndicator(
                strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                //value: 0.2,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            // Image.network(
            //   subCategories[index].displayImage,
            //   width: 50,
            //   height: 50,
            //   fit: BoxFit.cover,
            // ),
          );
        },
      ),
    );
  }
}
