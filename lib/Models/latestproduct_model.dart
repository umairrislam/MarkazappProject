class LatestProductModel {
  int? id;
  String? name;
  String?regularPrice;
  String?salePrice;
  String?type;
  String?averageRating;
  String?shortDescription;

  String? slug;
  String? price; // Make price nullable
  String? description;
  String? imageUrl;
  String?date_created;
  String? imageDateModifiedGmt;

  LatestProductModel({
    this.salePrice,
    this.averageRating,
    this.shortDescription,
    this.regularPrice,
    this.type,
    this.id,
    this.name,
    this.date_created,
    this.slug,
    this.price,
    this.description,
    this.imageUrl,
    this.imageDateModifiedGmt,
  });

  LatestProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    averageRating=json['averageRating'];
  salePrice=json["salePrice"];
    type=json['type'];
    slug = json['slug'];
    regularPrice=json["regularPrice"];
    name = json['name'];
    shortDescription=json['shortDescription'];
    price = (json['price']); // Parse the 'price' field from JSON
    description = json['description'];
    date_created=json['date_created'];

    // Fetch the first image's 'src' and 'date_modified_gmt' inside the 'images' array
    if (json.containsKey('images') && json['images'] is List<dynamic>) {
      List<dynamic> images = json['images'];
      if (images.isNotEmpty) {
        imageUrl = images[0]['src'];
        imageDateModifiedGmt = images[0]['date_modified_gmt'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categ = new Map<String, dynamic>();
    categ['id'] = id;
    categ['regularPrice']=regularPrice;
    categ['type']=type;
    categ['shortDescription']=shortDescription;
    categ['description'] = description;
    categ['slug'] = slug;
    categ['name'] = name;
    categ['date_created']=date_created;
categ["price"]=price;
    // Include 'images' array in the JSON if imageUrl is provided
    if (imageUrl != null) {
      categ['images'] = [
        {
          'src': imageUrl,
          'date_modified_gmt': imageDateModifiedGmt,
        }
      ];
    }

    return categ;
  }
}
