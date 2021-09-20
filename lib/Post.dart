class Post {
  int id;
  String title;
  String type;
  Uri imageurl;
  Map<String, dynamic> jsonget;

  Post(this.id, this.title, this.imageurl, this.type, this.jsonget);
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json["id"], json["title_ar"],
        Uri.parse("https://ourfamilybox.com/" + json["image"]), "card", json);
  }

  List<Post> list(type) {
    List<Post> newlist = [];
    for (var i = 0; i < this.jsonget[type].length; i++) {
      Post p = new Post(
          this.jsonget[type][i]["id"],
          this.jsonget[type][i]["title_ar"],
          Uri.parse(
              "https://ourfamilybox.com/" + this.jsonget[type][i]["image"]),
          "card",
          jsonget);

      newlist.add(p);
    }
    return newlist;
  }
}

class HomePageData {
  List<Post> postsCats = [];
  List<Post> postsections = [];
  List<Post> postcats_kawjkabes = [];
  List<Post> branches = [];
  HomePageData(psotcats, postsection, postkawakab, postbranch) {
    this.postsCats = psotcats;
    this.postsections = postsection;
    this.postcats_kawjkabes = postkawakab;
    this.branches = postbranch;
  }

  factory HomePageData.fromJson(Map<String, dynamic> json) {
    List<Post> postscats = [];
    for (var i = 0; i < json["cats"].length; i++) {
      Post postcats = Post.fromJson(json["cats"][i]);
      postscats.add(postcats);
    }

    List<Post> postsec = [];
    for (var i = 0; i < json["sections"].length; i++) {
      Post postcats = Post.fromJson(json["sections"][i]);
      postsec.add(postcats);
    }
    List<Post> catskawkab = [];
    for (var i = 0; i < json["cats_kawkab"].length; i++) {
      Post postcats = Post.fromJson(json["cats_kawkab"][i]);
      catskawkab.add(postcats);
    }
    List<Post> branch = [];
    for (var i = 0; i < json["branch"].length; i++) {
      Post postcats = Post.fromJson(json["branch"][i]);
      print("== " + postcats.title);
      branch.add(postcats);
    }

    return new HomePageData(postscats, postsec, catskawkab, branch);
  }
}

ListPosts getCats(Map<String, dynamic> json) {
  List<Post> postscats = [];
  for (var i = 0; i < json["cats"].length; i++) {
    Post postcats = Post.fromJson(json["cats"][i]);
    postscats.add(postcats);
  }
  return new ListPosts(postscats);
}

class ListPosts {
  List<Post> postsCats = [];
  List<Post> cats = [];
  ListPosts(psotcats) {
    this.postsCats = psotcats;
  }
  factory ListPosts.fromJson(Map<String, dynamic> json, String type) {
    List<Post> postscats = [];
    if (type != "data") {
      print("===== +++++++ =====" + json[type]["data"].length.toString());
      for (var i = 0; i < json[type]["data"].length; i++) {
        Post c = Post.fromJson(json[type]["data"][i]);

        postscats.add(c);
      }
    } else {
      for (var i = 0; i < json["data"].length; i++) {
        Post c = Post.fromJson(json["data"][i]);
        postscats.add(c);
      }
    }
    return new ListPosts(postscats);
  }
  List<Post> fromJsoncats(Map<String, dynamic> json, String type) {
    List<Post> catsp = [];
    if (type != "data") {
      for (var i = 0; i < json[type]["data"].length; i++) {
        Post c = Post.fromJson(json[type]["data"][i]);
        catsp.add(c);
      }
    } else {
      for (var i = 0; i < json["data"].length; i++) {
        Post c = Post.fromJson(json["data"][i]);
        catsp.add(c);
      }
    }

    return catsp;
  }
}
