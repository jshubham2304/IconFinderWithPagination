import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:iconfinder/api/api_service.dart';
import 'package:iconfinder/enums/response_enums.dart';
import 'package:iconfinder/model/icon.dart';
import 'package:permission_handler/permission_handler.dart';

class SearchNotifier extends ChangeNotifier {
  List<IconModel> iconsList = [];

  int totalCount = 0;
  String message = '';
  ResponseStatus status = ResponseStatus.NONE;

  void getSearchData(String val) async {
    try {
      if (val.isEmpty) {
        iconsList.clear();
        status = ResponseStatus.NONE;
      } else {
        status = ResponseStatus.PROCESSING;
        notifyListeners();
        var resp = await ApiService.searchIcon(val);
        print(resp.toString());
        if (resp != null) {
          var jsonList = resp['icons'] as List ?? [];
          totalCount = resp['total_count'] as int ?? 0;

          iconsList =
              jsonList.map<IconModel>((e) => IconModel.fromJson(e)).toList();
          status = ResponseStatus.FOUND;
        } else {
          status = ResponseStatus.NOTFOUND;
        }
      }
    } on SocketException {
      status = ResponseStatus.NOINTERNET;
    } catch (e) {
      status = ResponseStatus.ERROR;
    } finally {
      notifyListeners();
    }
  }

  void downloadIcon(String url, String name) async {
    requestPermission();
    message = 'Downloading Icons';
    notifyListeners();

    GallerySaver.saveImage(url).then((bool success) {
      if (success) {
        message = 'Icon Downloaded ';
      } else {
        message = 'Please try again to download the icon.';
      }
      notifyListeners();
    });
  }

  Future<void> getNextPageSearchingIcon(String text, int nextPage) async {
    try {
      if (text.isEmpty) {
        iconsList.clear();
        status = ResponseStatus.NONE;
      } else {
        status = ResponseStatus.PROCESSING;

        var resp = await ApiService.searchIcon(text, nextPage: nextPage);

        if (resp != null) {
          var jsonList = resp['icons'] as List ?? [];
          iconsList.addAll(
              jsonList.map<IconModel>((e) => IconModel.fromJson(e)).toList());

          status = ResponseStatus.FOUND;
        } else {
          status = ResponseStatus.NOTFOUND;
        }
      }
    } on SocketException {
      status = ResponseStatus.NOINTERNET;
    } catch (e) {
      status = ResponseStatus.ERROR;
    } finally {
      notifyListeners();
    }
  }

  requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }
}
