import 'package:familybox/Post.dart';
import 'package:familybox/layouts/WidgetPages.dart';
import 'package:familybox/pages/products/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cat extends StatefulWidget {
  int id = 1;
  Cat(this.id);

  @override
  StatePage createState() => StatePage(this.id);
}

class StatePage extends State<Cat> {
  int id = 1;
  List<Post> listposts = [];
  Map<String, dynamic> jsonapi = {};
  String url = "https://ourfamilybox.com";
  bool first = true;
  StatePage(int id) {
    this.first = false;
    this.url = "https://ourfamilybox.com/api/cats/" + id.toString();
    print(this.url);
  }

  Future getData() async {
    print("start");
    http.Response data = await http.get(Uri.parse(this.url));
    if (data.statusCode == 200) {
      //print(data.body);
      setState(() {
        jsonapi = json.decode(data.body);
        listposts = new ListPosts.fromJson(jsonapi, "products").postsCats;
        first = false;
      });
    } else {
      throw Exception("error the loading data ");
    }
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar().build(context),
        drawer: Drawerpages(),
        bottomNavigationBar: BottomNavigationBarpages(),
        body: StatefulBuilder(builder: (BuildContext context, setState) {(
          child: ListView.builder(
            itemCount: this.listposts.length,
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
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
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
                                    builder: (context) => new ProductPage(
                                        this.listposts[index].id)));
                          },
                        ),
                      ),
                    ],
                  ));
            },
          ),
        ));
  }
}
