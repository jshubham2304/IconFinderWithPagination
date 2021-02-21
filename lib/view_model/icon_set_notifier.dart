import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:iconfinder/api/api_service.dart';
import 'package:iconfinder/enums/response_enums.dart';
import 'package:iconfinder/model/icon_set.dart';

class IconSetNotifier extends ChangeNotifier {
  List<Iconsets> iconSets = [];

  int totalCount = 0;

  ResponseStatus status = ResponseStatus.PROCESSING;

  Future<void> getIconSetData(String categoryId) async {
    try {
      status = ResponseStatus.PROCESSING;
      notifyListeners();

      var resp = await ApiService.getIconSets(categoryId, null);

      if (resp != null) {
        var data = resp['iconsets'] as List ?? [];
        totalCount = resp['total_count'] as int ?? 0;

        iconSets = data.map<Iconsets>((e) => Iconsets.fromJson(e)).toList();

        status = ResponseStatus.FOUND;
        notifyListeners();
      } else {
        status = ResponseStatus.NOTFOUND;
        notifyListeners();
      }
    } on SocketException {
      status = ResponseStatus.NOINTERNET;
    } catch (e) {
      status = ResponseStatus.ERROR;
      notifyListeners();
    }
  }

  void getMoreIconSetData(String categoryId, Iconsets iconset) async {
    try {
      var resp = await ApiService.getIconSets(
        categoryId,
        iconset.iconsetId.toString(),
      );

      status = ResponseStatus.PROCESSING;

      var data = resp['iconsets'] as List ?? [];

      if (resp != null) {
        iconSets
            .addAll(data.map<Iconsets>((e) => Iconsets.fromJson(e)).toList());

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
