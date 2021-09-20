import 'ImageProduct.dart';

class Product {
  int id;
  String title;
  double price;
  String type;
  Uri imageurl;
  Map<String, dynamic> jsonget;
  List<ImageProduct> images = [];
  String desc = "";

  Product(this.id, this.title, this.imageurl, this.type, this.price, this.desc,
      this.jsonget);
  factory Product.fromJson(Map<String, dynamic> json) {
    print("-----------------------------");
    return Product(
        json["id"],
        json["title_ar"],
        Uri.parse("https://ourfamilybox.com/" + json["image"]),
        "nopayment",
        double.parse(json["price"]),
        json["desc_ar"],
        json);
  }

  List<ImageProduct> getImages() {
    List<ImageProduct> images = [];
    for (var i = 0; i < this.jsonget["images"].length; i++) {
      ImageProduct image = ImageProduct.fromJson(this.jsonget["images"][i]);
      images.add(image);
    }
    return images;
  }
}
