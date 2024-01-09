class CategoryModel {
  final String name;
  final String displayName;
  final String displayImage;
  final List<SubCategoryModel> subCategory;

  CategoryModel({
    required this.name,
    required this.displayName,
    required this.displayImage,
    required this.subCategory,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'],
      displayName: json['display_name'],
      displayImage: json['display_image'],
      subCategory: (json['sub_category'] as List<dynamic>)
          .map((subJson) => SubCategoryModel.fromJson(subJson))
          .toList(),
    );
  }
}

class SubCategoryModel {
  final String name;
  final String displayName;
  final String displayImage;

  SubCategoryModel({
    required this.name,
    required this.displayName,
    required this.displayImage,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      name: json['name'],
      displayName: json['display_name'],
      displayImage: json['display_image'],
    );
  }
}
