import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:iconfinder/api/api_service.dart';
import 'package:iconfinder/enums/response_enums.dart';
import 'package:iconfinder/model/api_response_model.dart';
import 'package:iconfinder/model/icon.dart';

class IconNotifier extends ChangeNotifier {
  List<IconModel> iconList = [];

  int totalCount = 0;

  ResponseStatus status = ResponseStatus.PROCESSING;

  Future<ApiResponseModel> getIconData(String id) async {
    try {
      iconList.clear();
      status = ResponseStatus.PROCESSING;
      notifyListeners();

      var resp = await ApiService.getIcon(id);

      if (resp != null) {
        var data = resp['icons'] as List ?? [];

        totalCount = resp['total_count'] as int ?? 0;

        iconList = data.map<IconModel>((e) => IconModel.fromJson(e)).toList();

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

  void getMoreIconData(String id, int nextPage) async {
    try {
      var resp = await ApiService.getIcon(id, nextPage: nextPage);
      print(resp);
      status = ResponseStatus.PROCESSING;

      if (resp != null) {
        var data = resp['icons'] as List;
        iconList
            .addAll(data.map<IconModel>((e) => IconModel.fromJson(e)).toList());

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
