import 'package:familybox/Post.dart';
import 'package:familybox/layouts/Loading.dart';
import 'package:familybox/layouts/WidgetPages.dart';
import 'package:familybox/pages/cats/cat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Section extends StatefulWidget {
  int id = 1;
  Section(this.id);

  @override
  StatePage createState() => StatePage(this.id);
}

class StatePage extends State<Section> {
  int id = 1;
  List<Post> listposts = [];
  Map<String, dynamic> jsonapi = {};
  String url = "https://ourfamilybox.com";
  bool fetchdata = false;

  StatePage(int id) {
    this.url = "https://ourfamilybox.com/api/sections/" + id.toString();
    print(this.url);
  }

  Future getData() async {
    print("start");
    http.Response data = await http.get(Uri.parse(this.url));
    if (data.statusCode == 200) {
      //print(data.body);
      setState(() {
        jsonapi = json.decode(data.body);
        listposts = new ListPosts.fromJson(jsonapi, "cats").postsCats;
        fetchdata = true;
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
                                    builder: (context) =>
                                        Cat(this.listposts[index].id)));
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
