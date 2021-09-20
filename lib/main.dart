import 'package:familybox/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'Post.dart';
import 'layouts/WidgetPages.dart';
import 'statepages.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Home());
  }
}

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> cats = [];
  List<Post> kawkabelfarah = [];
  List<Post> branches = [];
  Map<String, dynamic> jsonapi = {};

  @override
  Widget build(BuildContext context) {
    return SatePages(child: AppScafold());
  }
}

class AppScafold extends StatefulWidget {
  AppScafold({Key? key}) : super(key: key);

  @override
  _AppScafold createState() => _AppScafold();
}

class _AppScafold extends State<AppScafold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar().build(context),
      bottomNavigationBar: BottomNavigationBarpages(),
      drawer: Drawerpages(),
      body: new Page_Home(),
    );
  }
}
