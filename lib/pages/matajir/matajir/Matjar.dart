import 'package:familybox/Matjarinfo.dart';
import 'package:familybox/Post.dart';
import 'package:familybox/layouts/WidgetPages.dart';
import 'package:familybox/pages/matajir/products/ProductMatajir.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Matjar extends StatefulWidget {
  int id;
  Matjar(this.id);

  @override
  StatePage createState() => StatePage(this.id);
}

class StatePage extends State<Matjar> {
  List<Post> listposts = [];
  Map<String, dynamic> jsonapi = {};
  int id = 0;
  Matjarinfo matjar = new Matjarinfo(
      0, "title", Uri.parse("ur"), "phone", "whatssap", "instagram", {});

  Future getData() async {
    print("start");
    http.Response data = await http.get(Uri.parse(
        "https://ourfamilybox.com/api/matajir/matajir/" + this.id.toString()));
    if (data.statusCode == 200) {
      setState(() {
        jsonapi = json.decode(data.body);
        listposts = new ListPosts.fromJson(json.decode(data.body), "products")
            .postsCats;
        matjar = new Matjarinfo.fromJson(jsonapi["matjar"]);
      });
    } else {
      throw Exception("error the loading data ");
    }
  }

  StatePage(int id) {
    this.id = id;
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar().build(context),
      drawer: Drawerpages(),
      bottomNavigationBar: BottomNavigationBarpages(),
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Card(
              elevation: 2,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                children: [
                  Image.network(
                    this.matjar.imageurl.toString(),
                    fit: BoxFit.fill,
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    this.matjar.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          ListView.builder(
            itemCount: this.listposts.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 2,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Column(
                    children: [
                      Image.network(
                        this.listposts[index].imageurl.toString(),
                        fit: BoxFit.fill,
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: ListTile(
                          title: Text(
                            this.listposts[index].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => new ProductMatajir(
                                        this.listposts[index].id)));
                          },
                        ),
                      ),
                    ],
                  ));
            },
          ),
        ],
      ),
    );
  }
}
