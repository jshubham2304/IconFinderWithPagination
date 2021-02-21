class IconModel {
  List<Prices> prices;
  int iconId;
  List<Categories> categories;
  List<String> tags;
  String type;
  bool isIconGlyph;
  String publishedAt;
  List<Containers> containers;
  bool isPremium;
  List<VectorSizes> vectorSizes;
  List<RasterSizes> rasterSizes;

  IconModel(
      {this.prices,
      this.iconId,
      this.categories,
      this.tags,
      this.type,
      this.isIconGlyph,
      this.publishedAt,
      this.containers,
      this.isPremium,
      this.vectorSizes,
      this.rasterSizes});

  IconModel.fromJson(Map<String, dynamic> json) {
    iconId = json['icon_id'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(Categories.fromJson(v));
      });
    }

    tags = json['tags'].cast<String>();
    type = json['type'];
    isIconGlyph = json['is_icon_glyph'];
    publishedAt = json['published_at'];

    if (json['containers'] != null) {
      containers = [];
      json['containers'].forEach((v) {
        containers.add(Containers.fromJson(v));
      });
    }

    isPremium = json['is_premium'];
    if (json['vector_sizes'] != null) {
      vectorSizes = [];
      json['vector_sizes'].forEach((v) {
        vectorSizes.add(VectorSizes.fromJson(v));
      });
    }

    if (json['raster_sizes'] != null) {
      rasterSizes = [];
      json['raster_sizes'].forEach((v) {
        rasterSizes.add(RasterSizes.fromJson(v));
      });
    }
  }
}

class Prices {
  // License license;
  int price;
  String currency;

  Prices({this.price, this.currency});

  Prices.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    currency = json['currency'];
  }
}

class License {
  int licenseId;
  String scope;
  String url;
  String name;

  License({this.licenseId, this.scope, this.url, this.name});

  License.fromJson(Map<String, dynamic> json) {
    licenseId = json['license_id'];
    scope = json['scope'];
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['license_id'] = this.licenseId;
    data['scope'] = this.scope;
    data['url'] = this.url;
    data['name'] = this.name;
    return data;
  }
}

class Categories {
  String name;
  String identifier;

  Categories({this.name, this.identifier});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    identifier = json['identifier'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['identifier'] = this.identifier;
    return data;
  }
}

class Containers {
  String downloadUrl;
  String format;

  Containers({this.downloadUrl, this.format});

  Containers.fromJson(Map<String, dynamic> json) {
    downloadUrl = json['download_url'];
    format = json['format'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['download_url'] = this.downloadUrl;
    data['format'] = this.format;
    return data;
  }
}

class VectorSizes {
  List<Formats> formats;
  int sizeWidth;
  int sizeHeight;
  int size;

  VectorSizes({this.formats, this.sizeWidth, this.sizeHeight, this.size});

  VectorSizes.fromJson(Map<String, dynamic> json) {
    if (json['formats'] != null) {
      formats = [];
      json['formats'].forEach((v) {
        formats.add(Formats.fromJson(v));
      });
    }
    sizeWidth = json['size_width'];
    sizeHeight = json['size_height'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.formats != null) {
      data['formats'] = this.formats.map((v) => v.toJson()).toList();
    }
    data['size_width'] = this.sizeWidth;
    data['size_height'] = this.sizeHeight;
    data['size'] = this.size;
    return data;
  }
}

class RasterSizes {
  List<Formats> formats;
  int sizeWidth;
  int sizeHeight;
  int size;

  RasterSizes({this.formats, this.sizeWidth, this.sizeHeight, this.size});

  RasterSizes.fromJson(Map<String, dynamic> json) {
    if (json['formats'] != null) {
      formats = [];
      json['formats'].forEach((v) {
        formats.add(Formats.fromJson(v));
      });
    }
    sizeWidth = json['size_width'];
    sizeHeight = json['size_height'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.formats != null) {
      data['formats'] = this.formats.map((v) => v.toJson()).toList();
    }
    data['size_width'] = this.sizeWidth;
    data['size_height'] = this.sizeHeight;
    data['size'] = this.size;
    return data;
  }
}

class Formats {
  String downloadUrl;
  String format;
  String previewUrl;

  Formats({this.downloadUrl, this.format, this.previewUrl});

  Formats.fromJson(Map<String, dynamic> json) {
    downloadUrl = json['download_url'];
    format = json['format'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['download_url'] = this.downloadUrl;
    data['format'] = this.format;
    data['preview_url'] = this.previewUrl;
    return data;
  }
}
