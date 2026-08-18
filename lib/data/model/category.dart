class category {
  String? categoryId;
  String? categoryImage;
  String? categoryDatetime;
  String? categoryName;
  String? categoryNameAr;

  category(
      {this.categoryId,
        this.categoryImage,
        this.categoryDatetime,
        this.categoryName,
        this.categoryNameAr});

  category.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryImage = json['category_image'];
    categoryDatetime = json['category_datetime'];
    categoryName = json['category_name'];
    categoryNameAr = json['category_name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_image'] = this.categoryImage;
    data['category_datetime'] = this.categoryDatetime;
    data['category_name'] = this.categoryName;
    data['category_name_ar'] = this.categoryNameAr;
    return data;
  }
}