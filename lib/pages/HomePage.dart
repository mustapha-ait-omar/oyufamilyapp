import 'package:familybox/layouts/Loading.dart';
import 'package:familybox/pages/KawkabElfarah.dart';
import 'package:familybox/statepages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '/Post.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Page_Home extends StatefulWidget {
  Page_Home({Key? key}) : super(key: key);

  @override
  _Page_HomeState createState() => _Page_HomeState();
}

class _Page_HomeState extends State<Page_Home> {
  @override
  List<Post> cats = [];
  List<Post> kawkabelfarah = [];
  List<Post> branches = [];
  Map<String, dynamic> jsonapi = {};
  bool fetchdata = false;

  Future<HomePageData> getData() async {
    print("start");
    http.Response data =
        await http.get(Uri.parse("https://ourfamilybox.com/api"));
    if (data.statusCode == 200) {
      setState(() {
        jsonapi = json.decode(data.body);
        cats = HomePageData.fromJson(json.decode(data.body)).postsCats;
        kawkabelfarah =
            HomePageData.fromJson(json.decode(data.body)).postsections;
        branches = HomePageData.fromJson(json.decode(data.body)).branches;
      });
      fetchdata = true;
      return HomePageData.fromJson(json.decode(data.body));
    } else {
      throw Exception("error the loading data ");
    }
  }

  _Page_HomeState() {
    this.getData();
  }
  @override
  Widget build(BuildContext context) {
    if (this.fetchdata == false) {
      return Loading();
    }
    return StatefulBuilder(builder: (BuildContext context, setState) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text("kawkab el farah "),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {},
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.kawkabelfarah.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            children: [
                              Image.network(
                                this.kawkabelfarah[index].imageurl.toString(),
                                fit: BoxFit.fill,
                                height: 150,
                                width: 150,
                              ),
                              Text(
                                this.kawkabelfarah[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: Text("family matjar"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                print("price on kawkab el farah");
              },
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.cats.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            children: [
                              Image.network(
                                this.cats[index].imageurl.toString(),
                                fit: BoxFit.fill,
                                height: 150,
                                width: 150,
                              ),
                              Text(
                                this.cats[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),
            ),
            ListTile(
              title: Text("Branches"),
              trailing: Icon(Icons.arrow_forward),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: this.branches.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            children: [
                              Image.network(
                                this.branches[index].imageurl.toString(),
                                fit: BoxFit.fill,
                                height: 150,
                                width: 150,
                              ),
                              Text(
                                this.branches[index].title,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
