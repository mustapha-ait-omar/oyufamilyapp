class Matjarinfo {
  int id;
  String title;
  String phone;
  String instagram;
  String whatssap;
  Uri imageurl;
  Map<String, dynamic> jsonget;

  Matjarinfo(this.id, this.title, this.imageurl, this.phone, this.whatssap,
      this.instagram, this.jsonget);
  factory Matjarinfo.fromJson(Map<String, dynamic> json) {
    return Matjarinfo(
        json["id"],
        json["title_ar"],
        Uri.parse("https://ourfamilybox.com/" + json["image"]),
        json["phone_number"],
        json["whatssap"],
        json["instegram"],
        json);
  }
}
