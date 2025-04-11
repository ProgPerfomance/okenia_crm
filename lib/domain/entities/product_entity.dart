class ProductEntity {
  final String? id;
  final String langAlpha3Code;
  final String name;
  final String? categoryId;
  final List imageUrls;
  final List? tags;
  final double? price;
  final double? priceOld;
  final double? weidth;
  final String description;
  final String? tagId;
  final String? storageConditions;
  final String? usageRecommendations;
  final String? country;
  final String? mainImage;
  ProductEntity({
    this.tagId,
    this.id,
    required this.price,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.tags,
    required this.imageUrls,
    required this.priceOld,
    required this.weidth,
    required this.storageConditions,
    required this.usageRecommendations,
    required this.country,
    required this.langAlpha3Code,
    this.mainImage,
  });

  Map createJson() {
    return {
      'name': name,
      'langAlpha3Code': langAlpha3Code,
      'categoryId': categoryId,
      'images': imageUrls,
      'tags': tags,
      'price': price,
      'priceOld': priceOld,
      //'weidth': weidth,
      'description': description,
      'tagId': tagId,
      'storageConditions': storageConditions,
      'usageRecommendations': usageRecommendations,
      'country': country,
    };
  }

  factory ProductEntity.fromApi(Map map) {
    return ProductEntity(
      price: null,// map['price'],
      name: map['name'],
      categoryId: map['categoryId'],
      description: map['description'],
      tags: map['tags'],
      imageUrls: map['images'],
      priceOld: null,// map['priceOld'],
      weidth: null,//TODO MOCK
      storageConditions: map['storageConditions'],
      usageRecommendations: map['usageRecommendations'],
      country: map['country'],
      langAlpha3Code: map['langAlpha3Code'],
      id: map['_id'],
      mainImage: map['mainImage'],
    );
  }
}
