class ImageProduct {
  int id;
  Uri imageurl;
  Map<String, dynamic> jsonget;

  ImageProduct(this.id, this.imageurl, this.jsonget);
  factory ImageProduct.fromJson(Map<String, dynamic> json) {
    return ImageProduct(json["id"],
        Uri.parse("https://ourfamilybox.com/" + json["image"]), json);
  }
}

class Listimages {
  List<ImageProduct> images = [];

  Listimages(this.images);
  factory Listimages.fromJson(Map<String, dynamic> json) {
    List<ImageProduct> newimages = [];
    for (var i = 0; i < json["images"].length; i++) {
      ImageProduct image = ImageProduct.fromJson(json["images"][i]);
      newimages.add(image);
    }
    print("------- " + newimages.length.toString() + "-----------");
    return Listimages(newimages);
  }
}
