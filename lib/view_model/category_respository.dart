import 'package:flutter/cupertino.dart';
import 'package:iconfinder/api/api_service.dart';
import 'package:iconfinder/model/category.dart';

enum CategoryStatus { ItemProcessing, ItemFound, ItemNoFound, ItemError }

class CatgeoryRepo extends ChangeNotifier {
  Category nextCategory;

  List<Category> categoryList;
  String errorMessage = '';
  CategoryStatus status = CategoryStatus.ItemProcessing;

  CategoryRepo() {
    getCategoryData();
  }

  getCategoryData({bool isNext = false}) {
    try {
      status = CategoryStatus.ItemProcessing;
      notifyListeners();
      ApiService.getCategory(isNext ? nextCategory : null).then((response) {
        if (response != null) {
          var data = response['categories'] as List;

          if (isNext) {
            categoryList.addAll(
                data.map<Category>((e) => Category.fromJson(e)).toList());
          } else {
            categoryList =
                data.map<Category>((e) => Category.fromJson(e)).toList();
          }
          nextCategory = categoryList.last;
          status = CategoryStatus.ItemFound;
          notifyListeners();
        } else {
          status = CategoryStatus.ItemNoFound;
          errorMessage = 'No Category Found';
          notifyListeners();
        }
      }).catchError((e) {
        errorMessage = e;
        status = CategoryStatus.ItemError;
        notifyListeners();
      });
    } catch (e) {}
  }
}
