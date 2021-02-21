import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:iconfinder/api/api_service.dart';
import 'package:iconfinder/enums/response_enums.dart';
import 'package:iconfinder/model/category.dart';
import 'package:iconfinder/model/api_response_model.dart';

class CategoryNotifier extends ChangeNotifier {
  List<Category> categoryList;
  int totalCount = 0;

  ResponseStatus status = ResponseStatus.PROCESSING;

  Future<ApiResponseModel> getCategoryData() async {
    try {
      status = ResponseStatus.PROCESSING;
      notifyListeners();

      var resp = await ApiService.getCategory();

      if (resp != null) {
        var data = resp['categories'] as List ?? [];
        totalCount = resp['total_count'] as int ?? 0;

        categoryList = data.map<Category>((e) => Category.fromJson(e)).toList();

        status = ResponseStatus.FOUND;
        return ApiResponseModel(
          message: '',
          status: status,
        );
      } else {
        status = ResponseStatus.NOTFOUND;
        return ApiResponseModel(
          message: '',
          status: status,
        );
      }
    } on SocketException {
      status = ResponseStatus.NOINTERNET;
      return ApiResponseModel(
        message: 'No Internet! Please try again',
        status: status,
      );
    } catch (e) {
      status = ResponseStatus.ERROR;
      return ApiResponseModel(
        message: e.toString(),
        status: status,
      );
    } finally {
      notifyListeners();
    }
  }

  void getMoreCategoryData(Category category) async {
    try {
      var resp = await ApiService.getCategory(lastCategory: category);

      status = ResponseStatus.PROCESSING;

      if (resp != null) {
        var data = resp['categories'] as List ?? [];

        categoryList
            .addAll(data.map<Category>((e) => Category.fromJson(e)).toList());

        status = ResponseStatus.FOUND;
      } else {
        status = ResponseStatus.NOTFOUND;
      }
    } on SocketException {
      status = ResponseStatus.NOINTERNET;
    } catch (e) {
      status = ResponseStatus.ERROR;
    } finally {
      notifyListeners();
    }
  }
}
