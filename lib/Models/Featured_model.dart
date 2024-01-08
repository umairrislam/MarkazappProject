class FeaturedModel {
  int? id;
  String? name;
  String?type;
  String?regularPrice;
  String?salePrice;
  String? slug;
  String? description;
  String?date_created;
  String? imageUrl;
  String?price;
  String? imageDateModifiedGmt;

  FeaturedModel({
    this.regularPrice,
    this.salePrice,
    this.type,
    this.date_created,
    this.price,
    this.id,
    this.slug,
    this.name,
    this.description,
    this.imageUrl,
    this.imageDateModifiedGmt,
  });

  FeaturedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    salePrice=json['salePrice'];
    regularPrice=json['regularPrice'];
    type=json['type'];
    slug = json['slug'];
    name = json['name'];
    description = json['description'];
     price = (json['price']);
     date_created=json['date_created'] ;

    // Fetch the first image's 'src' and 'date_modified_gmt' inside the 'images' array
    if (json.containsKey('images') && json['images'] is List<dynamic>) {
      if (json['images'].isNotEmpty) {
        imageUrl = json['images'][0]['src'];
        imageDateModifiedGmt = json['images'][0]['date_modified_gmt'];
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> categ = new Map<String, dynamic>();
    categ['id'] = id;
    categ['type']=type;
    categ['regularPrice']=regularPrice;
    categ['salePrice']=salePrice;
    categ['description'] = description;
    categ['slug'] = slug;
    categ['name'] = name;
    categ["price"]=price;
    categ["date_created"]=date_created;

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
