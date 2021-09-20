import 'package:familybox/ImageProduct.dart';
import 'package:familybox/Product.dart';
import 'package:familybox/layouts/WidgetPages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_html/flutter_html.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductMatajir extends StatefulWidget {
  int id = 1;
  ProductMatajir(this.id);

  @override
  StatePage createState() => StatePage(this.id);
}

class StatePage extends State<ProductMatajir> {
  int id = 1;
  bool first = true;
  Product product = new Product(
      0,
      "title",
      Uri.parse("https://ourfamilybox.com/upload/images/1630347937994.png"),
      "",
      0,
      "", {});
  List<ImageProduct> images = [];
  Map<String, dynamic> jsonapi = {};
  String url = "https://ourfamilybox.com";

  StatePage(int id) {
    this.url = "https://ourfamilybox.com/api/matajir/products/" + id.toString();
    print(this.url);
    first = true;
  }

  Future getData() async {
    print("start");
    http.Response data = await http.get(Uri.parse(this.url));
    if (data.statusCode == 200) {
      //print(data.body);
      setState(() {
        jsonapi = json.decode(data.body);
        product = new Product.fromJson(jsonapi);
        ImageProduct img =
            new ImageProduct(0, product.imageurl, product.jsonget);
        images = Listimages.fromJson(jsonapi).images;
        images.insert(0, img);
        first = false;
      });
    } else {
      throw Exception("error the loading data ");
    }
  }

  @override
  void initState() {
    this.first = true;
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar().build(context),
        drawer: Drawerpages(),
        bottomNavigationBar: BottomNavigationBarpages(),
        body: Container(
          child: Card(
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: ListView(children: [
                CarouselSlider.builder(
                  itemCount: this.images.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 1.5,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (context, index, realIdx) {
                    if (this.images.length == 0 && this.first == true) {
                      return Container(
                          child: Center(
                        child: Text("data loading ..."),
                      ));
                    } else {
                      return Container(
                        child: Center(
                            child: Image.network(
                                this.images[index].imageurl.toString(),
                                fit: BoxFit.cover,
                                width: 1000)),
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Text(
                      this.product.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      print("index");
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Text(
                      this.product.price.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Html(
                      data: this.product.desc,
                      style: {"*": Style(textAlign: TextAlign.center)},
                    )),
              ])),
        ));
  }
}
