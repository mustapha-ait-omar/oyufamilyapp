import 'package:familybox/Post.dart';
import 'package:familybox/layouts/Loading.dart';
import 'package:familybox/layouts/WidgetPages.dart';
import 'package:familybox/pages/matajir/matajir/Matjar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatMatajir extends StatefulWidget {
  int id;
  CatMatajir(this.id);

  @override
  StatePage createState() => StatePage(this.id);
}

class StatePage extends State<CatMatajir> {
  List<Post> listposts = [];
  Map<String, dynamic> jsonapi = {};
  int id = 0;
  bool fetchdata = false;

  Future getData() async {
    print("start");
    http.Response data = await http.get(Uri.parse(
        "https://ourfamilybox.com/api/matajir/cats/" + this.id.toString()));
    if (data.statusCode == 200) {
      setState(() {
        jsonapi = json.decode(data.body);
        listposts =
            new ListPosts.fromJson(json.decode(data.body), "matajir").postsCats;
        fetchdata = true;
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
        body: Container(
          child: ListView.builder(
            itemCount: this.listposts.length,
            itemBuilder: (BuildContext context, int index) {
              if (this.fetchdata == false) {
                return Loading();
              }
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
                                    builder: (context) =>
                                        Matjar(this.listposts[index].id)));
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
