import 'package:iconfinder/model/icon.dart';

class Iconsets {
  bool isPremium;
  bool areAllIconsGlyph;
  String name;
  int iconsCount;
  List<Prices> prices;
  List<Icons> icons;
  List<Categories> categories;
  int iconsetId;
  String type;
  String identifier;
  Author author;
  String publishedAt;

  Iconsets(
      {this.isPremium,
      this.areAllIconsGlyph,
      this.name,
      this.iconsCount,
      this.prices,
      this.categories,
      this.iconsetId,
      this.type,
      this.icons,
      this.identifier,
      this.author,
      this.publishedAt});

  Iconsets.fromJson(Map<String, dynamic> json) {
    isPremium = json['is_premium'];
    areAllIconsGlyph = json['are_all_icons_glyph'];
    name = json['name'];
    iconsCount = json['icons_count'];

    if (json['prices'] != null) {
      prices = new List<Prices>();
      json['prices'].forEach((v) {
        prices.add(new Prices.fromJson(v));
      });
    }
    //print("====1");
    if (json['icons'] != null) {
      icons = new List<Icons>();
      json['icons'].forEach((v) {
        icons.add(new Icons.fromJson(v));
      });
    } else {
      icons = null;
    }
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    iconsetId = json['iconset_id'];
    type = json['type'];
    identifier = json['identifier'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    publishedAt = json['published_at'];
    //print("====3");
  }
}

class Prices {
  String currency;
  // License license;
  String price;

  Prices({this.currency, this.price});

  Prices.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    price = json['price'].toString();
  }
}

class Author {
  String username;
  String name;
  String company;
  int userId;
  bool isDesigner;
  int iconsetsCount;

  Author(
      {this.username,
      this.name,
      this.company,
      this.userId,
      this.isDesigner,
      this.iconsetsCount});

  Author.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    company = json['company'];
    userId = json['user_id'];
    isDesigner = json['is_designer'];
    iconsetsCount = json['iconsets_count'];
  }
}
