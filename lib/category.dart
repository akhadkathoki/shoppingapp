class Categories {
  final String name;

  Categories(this.name);

  factory Categories.fromJson(dynamic json) {
    return Categories(json as String);
  }

  static List<Categories> getCategoryList(List<dynamic> jsonList) {
    List<Categories> categoryList = [];
    for (int i = 0; i < jsonList.length; i++) {
      categoryList.add(Categories.fromJson(jsonList[i]));
    }
    return categoryList;
  }
}
