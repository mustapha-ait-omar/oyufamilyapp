import "package:flutter/material.dart";
import "pages/HomePage.dart";
import "pages/kawkabelfarah.dart";

class SatePages extends InheritedWidget {
  final List<Widget> listroutes = [Page_Home(), KawkabElfarah()];
  int indexrouter = 0;
  Widget pageindex = Page_Home();
  SatePages({
    required Widget child,
  }) : super(child: child);
  @override
  bool updateShouldNotify(SatePages old) => pageindex != old.pageindex;
  static SatePages of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SatePages>() as SatePages;
  }
}
