

class ProductModel {
  int? id;
  String? date;
  String? name;
  String? slug;
  List<ImageModel>? images;
  String? price; 
  String?date_created;
   String? regularPrice;
   String?type;
    String? salePrice;
  String?description;
  String?average_rating;// Added this field for price HTML

  ProductModel({
    this.type,
    this.date_created,
    this.description,
    this.average_rating,
    this.regularPrice,
    this.salePrice,
    this.name,
    this.id,
    this.date,
    this.slug,
    this.images,
    this.price,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    slug = json['slug'];
    type=json['type'];
     regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    date_created=json["date_created"];
    price= (json['price']); 
description=json["description"];
    if (json['images'] != null) {
      images = <ImageModel>[];
      json['images'].forEach((imageData) {
        images?.add(ImageModel.fromJson(imageData));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
     data['regular_price'] = regularPrice;
    data['sale_price'] = salePrice;
    data['name'] = name;
    data['type']=type;
    data['slug'] = slug;
    data["date_created"]=date_created;
    data['price'] = price; 
data["description"]=description;
    if (images != null) {
      data['images'] = images?.map((e) => e.toJson()).toList();
    }

    return data;
  }
}

class ImageModel {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  
  String? alt;

  ImageModel({
   
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
   
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
    data['src'] = src;
    data['name'] = name;
    data['alt'] = alt;
   
    return data;
  }
}
