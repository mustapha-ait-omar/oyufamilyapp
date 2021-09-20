import 'package:familybox/pages/HomePage.dart';
import 'package:familybox/pages/KawkabElfarah.dart';
import 'package:familybox/pages/matajir/categories/CatsMatajir.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  AppBar build(BuildContext context) {
    return AppBar(
      title: Text("familyBox"),
    );
  }
}

class BottomNavigationBarpages extends StatelessWidget {
  @override
  BottomNavigationBar build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag),
          label: 'Card',
        ),
      ],
    );
  }
}

class Drawerpages extends StatelessWidget {
  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Home '),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
          ),
          ListTile(
            title: const Text('kawkab el farah '),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KawkabElfarah()));
            },
          ),
          ListTile(
            title: const Text('cats matajir'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CatsMatajir()));
            },
          ),
        ],
      ),
    );
  }
}
