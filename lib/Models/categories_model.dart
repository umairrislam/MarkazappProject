class CategoriesModel {
  int? id;
  String? name;
  String? slug;
  String? description;
  String? imageUrl;
  String? imageDateModifiedGmt; // Add this property for 'date_modified_gmt' inside 'image'

  CategoriesModel({
    this.id,
    this.slug,
    this.name,
    this.description,
    this.imageUrl,
    this.imageDateModifiedGmt,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    description = json['description'];

    // Fetch 'src' and 'date_modified_gmt' inside the 'image' object
    if (json.containsKey('image') && json['image'] is Map<String, dynamic>) {
      imageUrl = json['image']['src'];
      imageDateModifiedGmt = json['image']['date_modified_gmt'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categ = new Map<String, dynamic>();
    categ['id'] = id;
    categ['description'] = description;
    categ['slug'] = slug;
    categ['name'] = name;

    // Include 'image' object in the JSON if imageUrl is provided
    if (imageUrl != null) {
      categ['image'] = {
        'src': imageUrl,
        'date_modified_gmt': imageDateModifiedGmt,
      };
    }

    return categ;
  }
}
