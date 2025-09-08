class ProductDetailsModel {
  int? id;
  String? name;
  final bool isFavorite;
  final bool isAddedToCart;
  String? slug;
  String? permalink;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  int? downloadLimit;
  int? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  int? parentId;
  String? purchaseNote;
  List<Categories>? categories;
  List<Images>? images;
  List<Attributes>? attributes;
  int? menuOrder;
  String? priceHtml;
  List<MetaData>? metaData;
  String? stockStatus;
  bool? hasOptions;
  String? postPassword;
  String? yoastHead;
  YoastHeadJson? yoastHeadJson;
  List<Brands>? brands;
  Links? lLinks;
  List<DefaultAttributes>? defaultAttributes;
  List<int>? variations;
  List<int>? groupedProducts;
  List<Tags>? tags;
  List<Downloads>? downloads;
  List<int>? relatedIds;
  List<dynamic>? bundledBy;
  String? bundleStockStatus;
  int? bundleStockQuantity;
  bool? bundleVirtual;
  String? bundleLayout;
  String? bundleAddToCartFormLocation;
  bool? bundleEditableInCart;
  bool? bundleSoldIndividuallyContext;
  String? bundleItemGrouping;
  String? bundleMinSize;
  String? bundleMaxSize;
  List<dynamic>? bundlePrice;
  List<dynamic>? bundledItems;
  List<dynamic>? bundleSellIds;

  ProductDetailsModel({
    this.id,
    this.name,
    required this.isFavorite,
    required this.isAddedToCart,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.images,
    this.attributes,
    this.menuOrder,
    this.priceHtml,
    this.metaData,
    this.stockStatus,
    this.hasOptions,
    this.postPassword,
    this.yoastHead,
    this.yoastHeadJson,
    this.brands,
    this.lLinks,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.tags,
    this.downloads,
    this.relatedIds,
    this.bundledBy,
    this.bundleStockStatus,
    this.bundleStockQuantity,
    this.bundleVirtual,
    this.bundleLayout,
    this.bundleAddToCartFormLocation,
    this.bundleEditableInCart,
    this.bundleSoldIndividuallyContext,
    this.bundleItemGrouping,
    this.bundleMinSize,
    this.bundleMaxSize,
    this.bundlePrice,
    this.bundledItems,
    this.bundleSellIds,
  });

  ProductDetailsModel copyWith({
    int? id,
    String? name,
    bool? isFavorite,
    bool? isAddedToCart,
    // other fields...
  }) {
    return ProductDetailsModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
      // other fields...
    );
  }

  ProductDetailsModel.fromJson(
    Map<String, dynamic> json, {
    this.isFavorite = false,
    this.isAddedToCart = false,
  }) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = parseBool(json['featured']);
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];

    onSale = parseBool(json['on_sale']);
    purchasable = parseBool(json['purchasable']);
    totalSales = json['total_sales'];
    virtual = parseBool(json['virtual']);
    downloadable = parseBool(json['downloadable']);

    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = parseBool(json['manage_stock']);
    backorders = json['backorders'];
    backordersAllowed = parseBool(json['backorders_allowed']);
    backordered = parseBool(json['backordered']);
    soldIndividually = parseBool(json['sold_individually']);
    weight = json['weight'];
    dimensions =
        json['dimensions'] != null
            ? new Dimensions.fromJson(json['dimensions'])
            : null;
    shippingRequired = parseBool(json['shipping_required']);
    shippingTaxable = parseBool(json['shipping_taxable']);
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = parseBool(json['reviews_allowed']);
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];

    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }

    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }

    menuOrder = json['menu_order'];
    priceHtml = json['price_html'];
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData!.add(new MetaData.fromJson(v));
      });
    }
    stockStatus = json['stock_status'];
    hasOptions = parseBool(json['has_options']);
    postPassword = json['post_password'];
    yoastHead = json['yoast_head'];
    yoastHeadJson =
        json['yoast_head_json'] != null
            ? new YoastHeadJson.fromJson(json['yoast_head_json'])
            : null;
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
    if (json['default_attributes'] != null) {
      defaultAttributes = <DefaultAttributes>[];
      json['default_attributes'].forEach((v) {
        defaultAttributes!.add(new DefaultAttributes.fromJson(v));
      });
    }
    if (json['variations'] != null) {
      variations = List<int>.from(json['variations']);
    }
    if (json['grouped_products'] != null) {
      groupedProducts = List<int>.from(json['grouped_products']);
    }
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    if (json['downloads'] != null) {
      downloads = <Downloads>[];
      json['downloads'].forEach((v) {
        downloads!.add(new Downloads.fromJson(v));
      });
    }
    if (json['related_ids'] != null) {
      relatedIds = List<int>.from(json['related_ids']);
    }
    if (json['bundled_by'] != null) {
      bundledBy = List<dynamic>.from(json['bundled_by']);
    }
    bundleStockStatus = json['bundle_stock_status'];
    bundleStockQuantity = json['bundle_stock_quantity'];
    bundleVirtual = parseBool(json['bundle_virtual']);
    bundleLayout = json['bundle_layout'];
    bundleAddToCartFormLocation = json['bundle_add_to_cart_form_location'];
    bundleEditableInCart = parseBool(json['bundle_editable_in_cart']);
    bundleSoldIndividuallyContext = parseBool(
      json['bundle_sold_individually_context'],
    );
    bundleItemGrouping = json['bundle_item_grouping'];
    bundleMinSize = json['bundle_min_size'];
    bundleMaxSize = json['bundle_max_size'];
    if (json['bundle_price'] != null) {
      bundlePrice = List<dynamic>.from(json['bundle_price']);
    }
    if (json['bundled_items'] != null) {
      bundledItems = List<dynamic>.from(json['bundled_items']);
    }
    if (json['bundle_sell_ids'] != null) {
      bundleSellIds = List<dynamic>.from(json['bundle_sell_ids']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['permalink'] = this.permalink;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['type'] = this.type;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['catalog_visibility'] = this.catalogVisibility;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;

    data['on_sale'] = this.onSale;
    data['purchasable'] = this.purchasable;
    data['total_sales'] = this.totalSales;
    data['virtual'] = this.virtual;
    data['downloadable'] = this.downloadable;

    data['download_limit'] = this.downloadLimit;
    data['download_expiry'] = this.downloadExpiry;
    data['external_url'] = this.externalUrl;
    data['button_text'] = this.buttonText;
    data['tax_status'] = this.taxStatus;
    data['tax_class'] = this.taxClass;
    data['manage_stock'] = this.manageStock;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backordersAllowed;
    data['backordered'] = this.backordered;
    data['sold_individually'] = this.soldIndividually;
    data['weight'] = this.weight;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions!.toJson();
    }
    data['shipping_required'] = this.shippingRequired;
    data['shipping_taxable'] = this.shippingTaxable;
    data['shipping_class'] = this.shippingClass;
    data['shipping_class_id'] = this.shippingClassId;
    data['reviews_allowed'] = this.reviewsAllowed;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;

    data['parent_id'] = this.parentId;
    data['purchase_note'] = this.purchaseNote;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }

    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }

    data['menu_order'] = this.menuOrder;
    data['price_html'] = this.priceHtml;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    }
    data['stock_status'] = this.stockStatus;
    data['has_options'] = this.hasOptions;
    data['post_password'] = this.postPassword;
    data['yoast_head'] = this.yoastHead;
    if (this.yoastHeadJson != null) {
      data['yoast_head_json'] = this.yoastHeadJson!.toJson();
    }
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    if (this.defaultAttributes != null) {
      data['default_attributes'] =
          this.defaultAttributes!.map((v) => v.toJson()).toList();
    }
    if (this.variations != null) {
      data['variations'] = this.variations;
    }
    if (this.groupedProducts != null) {
      data['grouped_products'] = this.groupedProducts;
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.downloads != null) {
      data['downloads'] = this.downloads!.map((v) => v.toJson()).toList();
    }
    if (this.relatedIds != null) {
      data['related_ids'] = this.relatedIds;
    }
    if (this.bundledBy != null) {
      data['bundled_by'] = this.bundledBy;
    }
    data['bundle_stock_status'] = this.bundleStockStatus;
    data['bundle_stock_quantity'] = this.bundleStockQuantity;
    data['bundle_virtual'] = this.bundleVirtual;
    data['bundle_layout'] = this.bundleLayout;
    data['bundle_add_to_cart_form_location'] = this.bundleAddToCartFormLocation;
    data['bundle_editable_in_cart'] = this.bundleEditableInCart;
    data['bundle_sold_individually_context'] =
        this.bundleSoldIndividuallyContext;
    data['bundle_item_grouping'] = this.bundleItemGrouping;
    data['bundle_min_size'] = this.bundleMinSize;
    data['bundle_max_size'] = this.bundleMaxSize;
    if (this.bundlePrice != null) {
      data['bundle_price'] = this.bundlePrice;
    }
    if (this.bundledItems != null) {
      data['bundled_items'] = this.bundledItems;
    }
    if (this.bundleSellIds != null) {
      data['bundle_sell_ids'] = this.bundleSellIds;
    }
    return data;
  }
}

class Dimensions {
  String? length;
  String? width;
  String? height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Categories {
  int? id;
  String? name;
  String? slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Images {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? src;
  String? name;
  String? alt;

  Images({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.src,
    this.name,
    this.alt,
  });

  Images.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  String? slug;
  int? position;
  bool? visible;
  bool? variation;
  List<dynamic>? options;

  Attributes({
    this.id,
    this.name,
    this.slug,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['options'] = this.options;
    return data;
  }
}

class MetaData {
  int? id;
  String? key;
  dynamic value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class YoastHeadJson {
  String? title;
  String? description;
  Robots? robots;
  String? canonical;
  String? ogLocale;
  String? ogType;
  String? ogTitle;
  String? ogDescription;
  String? ogUrl;
  String? ogSiteName;
  String? articlePublisher;
  String? articleModifiedTime;
  List<OgImage>? ogImage;
  Schema? schema;

  YoastHeadJson({
    this.title,
    this.description,
    this.robots,
    this.canonical,
    this.ogLocale,
    this.ogType,
    this.ogTitle,
    this.ogDescription,
    this.ogUrl,
    this.ogSiteName,
    this.articlePublisher,
    this.articleModifiedTime,
    this.ogImage,
    this.schema,
  });

  YoastHeadJson.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    robots =
        json['robots'] != null ? new Robots.fromJson(json['robots']) : null;
    canonical = json['canonical'];
    ogLocale = json['og_locale'];
    ogType = json['og_type'];
    ogTitle = json['og_title'];
    ogDescription = json['og_description'];
    ogUrl = json['og_url'];
    ogSiteName = json['og_site_name'];
    articlePublisher = json['article_publisher'];
    articleModifiedTime = json['article_modified_time'];
    if (json['og_image'] != null) {
      ogImage = <OgImage>[];
      json['og_image'].forEach((v) {
        ogImage!.add(new OgImage.fromJson(v));
      });
    }
    schema =
        json['schema'] != null ? new Schema.fromJson(json['schema']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.robots != null) {
      data['robots'] = this.robots!.toJson();
    }
    data['canonical'] = this.canonical;
    data['og_locale'] = this.ogLocale;
    data['og_type'] = this.ogType;
    data['og_title'] = this.ogTitle;
    data['og_description'] = this.ogDescription;
    data['og_url'] = this.ogUrl;
    data['og_site_name'] = this.ogSiteName;
    data['article_publisher'] = this.articlePublisher;
    data['article_modified_time'] = this.articleModifiedTime;
    if (this.ogImage != null) {
      data['og_image'] = this.ogImage!.map((v) => v.toJson()).toList();
    }
    if (this.schema != null) {
      data['schema'] = this.schema!.toJson();
    }
    return data;
  }
}

class Robots {
  String? index;
  String? follow;
  String? maxSnippet;
  String? maxImagePreview;
  String? maxVideoPreview;

  Robots({
    this.index,
    this.follow,
    this.maxSnippet,
    this.maxImagePreview,
    this.maxVideoPreview,
  });

  Robots.fromJson(Map<String, dynamic> json) {
    index = json['index'];
    follow = json['follow'];
    maxSnippet = json['max-snippet'];
    maxImagePreview = json['max-image-preview'];
    maxVideoPreview = json['max-video-preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['index'] = this.index;
    data['follow'] = this.follow;
    data['max-snippet'] = this.maxSnippet;
    data['max-image-preview'] = this.maxImagePreview;
    data['max-video-preview'] = this.maxVideoPreview;
    return data;
  }
}

class OgImage {
  int? width;
  int? height;
  String? url;
  String? type;

  OgImage({this.width, this.height, this.url, this.type});

  OgImage.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class Schema {
  String? context;
  List<Graph>? graph;

  Schema({this.context, this.graph});

  Schema.fromJson(Map<String, dynamic> json) {
    context = json['@context'];
    if (json['@graph'] != null) {
      graph = <Graph>[];
      json['@graph'].forEach((v) {
        graph!.add(new Graph.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@context'] = this.context;
    if (this.graph != null) {
      data['@graph'] = this.graph!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Graph {
  String? type;
  String? id;
  String? url;
  String? name;
  IsPartOf? isPartOf;
  String? datePublished;
  String? dateModified;
  String? description;
  IsPartOf? breadcrumb;
  String? inLanguage;
  List<PotentialAction>? potentialAction;
  List<ItemListElement>? itemListElement;
  IsPartOf? publisher;
  Logo? logo;
  IsPartOf? image;

  Graph({
    this.type,
    this.id,
    this.url,
    this.name,
    this.isPartOf,
    this.datePublished,
    this.dateModified,
    this.description,
    this.breadcrumb,
    this.inLanguage,
    this.potentialAction,
    this.itemListElement,
    this.publisher,
    this.logo,
    this.image,
  });

  Graph.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    id = json['@id'];
    url = json['url'];
    name = json['name'];
    isPartOf =
        json['isPartOf'] != null
            ? new IsPartOf.fromJson(json['isPartOf'])
            : null;
    datePublished = json['datePublished'];
    dateModified = json['dateModified'];
    description = json['description'];
    breadcrumb =
        json['breadcrumb'] != null
            ? new IsPartOf.fromJson(json['breadcrumb'])
            : null;
    inLanguage = json['inLanguage'];
    if (json['potentialAction'] != null) {
      potentialAction = <PotentialAction>[];
      if (json['potentialAction'] is List) {
        json['potentialAction'].forEach((v) {
          if (v is Map<String, dynamic>) {
            potentialAction!.add(new PotentialAction.fromJson(v));
          }
          // إذا كان نوع آخر تجاهله أو أضف معالجة خاصة إذا أردت
        });
      } else if (json['potentialAction'] is Map<String, dynamic>) {
        potentialAction!.add(
          new PotentialAction.fromJson(json['potentialAction']),
        );
      }
      // إذا كان String أو نوع آخر تجاهله أو خزنه كنص إذا أردت
    }
    if (json['itemListElement'] != null) {
      itemListElement = <ItemListElement>[];
      json['itemListElement'].forEach((v) {
        itemListElement!.add(new ItemListElement.fromJson(v));
      });
    }
    publisher =
        json['publisher'] != null
            ? new IsPartOf.fromJson(json['publisher'])
            : null;
    logo = json['logo'] != null ? new Logo.fromJson(json['logo']) : null;
    image = json['image'] != null ? new IsPartOf.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['@id'] = this.id;
    data['url'] = this.url;
    data['name'] = this.name;
    if (this.isPartOf != null) {
      data['isPartOf'] = this.isPartOf!.toJson();
    }
    data['datePublished'] = this.datePublished;
    data['dateModified'] = this.dateModified;
    data['description'] = this.description;
    if (this.breadcrumb != null) {
      data['breadcrumb'] = this.breadcrumb!.toJson();
    }
    data['inLanguage'] = this.inLanguage;
    if (this.potentialAction != null) {
      data['potentialAction'] =
          this.potentialAction!.map((v) => v.toJson()).toList();
    }
    if (this.itemListElement != null) {
      data['itemListElement'] =
          this.itemListElement!.map((v) => v.toJson()).toList();
    }
    if (this.publisher != null) {
      data['publisher'] = this.publisher!.toJson();
    }
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class IsPartOf {
  String? id;

  IsPartOf({this.id});

  IsPartOf.fromJson(Map<String, dynamic> json) {
    id = json['@id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@id'] = this.id;
    return data;
  }
}

class PotentialAction {
  String? type;
  String? queryInput;

  PotentialAction({this.type, this.queryInput});

  PotentialAction.fromJson(Map<String, dynamic> json) {
    type = json['@type']?.toString();
    queryInput = json['query-input']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['query-input'] = this.queryInput;
    return data;
  }
}

class ItemListElement {
  String? type;
  int? position;
  String? name;
  String? item;

  ItemListElement({this.type, this.position, this.name, this.item});

  ItemListElement.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    position = json['position'];
    name = json['name'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['position'] = this.position;
    data['name'] = this.name;
    data['item'] = this.item;
    return data;
  }
}

class Logo {
  String? type;
  String? inLanguage;
  String? id;
  String? url;
  String? contentUrl;
  int? width;
  int? height;
  String? caption;

  Logo({
    this.type,
    this.inLanguage,
    this.id,
    this.url,
    this.contentUrl,
    this.width,
    this.height,
    this.caption,
  });

  Logo.fromJson(Map<String, dynamic> json) {
    type = json['@type'];
    inLanguage = json['inLanguage'];
    id = json['@id'];
    url = json['url'];
    contentUrl = json['contentUrl'];
    width = json['width'];
    height = json['height'];
    caption = json['caption'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['@type'] = this.type;
    data['inLanguage'] = this.inLanguage;
    data['@id'] = this.id;
    data['url'] = this.url;
    data['contentUrl'] = this.contentUrl;
    data['width'] = this.width;
    data['height'] = this.height;
    data['caption'] = this.caption;
    return data;
  }
}

class Links {
  List<Self>? self;
  List<CollectionProductDetails>? collection;

  Links({this.self, this.collection});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <Self>[];
      json['self'].forEach((v) {
        self!.add(new Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = <CollectionProductDetails>[];
      json['collection'].forEach((v) {
        collection!.add(new CollectionProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.map((v) => v.toJson()).toList();
    }
    if (this.collection != null) {
      data['collection'] = this.collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CollectionProductDetails {
  CollectionProductDetails({required this.href});
  late final String href;

  CollectionProductDetails.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['href'] = href;
    return _data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}

class Brands {
  int? id;
  String? name;
  String? slug;

  Brands({this.id, this.name, this.slug});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class DefaultAttributes {
  int? id;
  String? name;
  String? option;

  DefaultAttributes({this.id, this.name, this.option});

  DefaultAttributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    option = json['option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['option'] = this.option;
    return data;
  }
}

class Tags {
  int? id;
  String? name;
  String? slug;

  Tags({this.id, this.name, this.slug});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Downloads {
  String? id;
  String? name;
  String? file;

  Downloads({this.id, this.name, this.file});

  Downloads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['file'] = this.file;
    return data;
  }
}

bool parseBool(dynamic value) {
  if (value is bool) return value;
  if (value is String) return value.toLowerCase() == 'true';
  if (value is int) return value == 1;
  return false;
}
