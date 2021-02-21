import 'package:flutter/foundation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:iconfinder/api/api_service.dart';
import 'package:iconfinder/model/icon.dart';
import 'package:iconfinder/view_model/icon_set_repository.dart';

class SearchRepo extends ChangeNotifier {
  List<Icons> icons = new List<Icons>();
  IconStatus status = IconStatus.IconProcessing;
  int nextpage = 0;
  String searchValue;
  String message = '';
  searchingIcon(String val) {
    try {
      if (val == null || val.length == 0) {
        icons.clear();
        searchValue = val;
      } else {
        searchValue = val;
        status = IconStatus.IconProcessing;
        notifyListeners();
        ApiService.searchIcon(val).then((value) {
          if (value != null) {
            var jsonList = value['icons'] as List;
            icons = jsonList.map<Icons>((e) => Icons.fromJson(e)).toList();
            status = IconStatus.IconFound;
            notifyListeners();
          }
        }).catchError((e) {
          status = IconStatus.IconError;
          notifyListeners();
        });
      }
    } catch (e) {
      status = IconStatus.IconError;
      notifyListeners();
    }
  }

  downloadIcon(String url, String name) async {
    message = 'Downloading Icons';
    notifyListeners();

    GallerySaver.saveImage(url).then((bool success) {
      if (success) {
        message = 'Icon Saved'; ////
      } else {
        message = 'Icon is not saved';
      }
      notifyListeners();
    });
  }

  getNextPageSearchingIcon() {
    try {
      if (searchValue == null || searchValue.length == 0) {
        icons.clear();
      } else {
        status = IconStatus.IconProcessing;
        notifyListeners();
        nextpage++;
        ApiService.searchIcon(searchValue, nextpage: nextpage).then((value) {
          if (value != null) {
            var jsonList = value['icons'] as List;
            icons
                .addAll(jsonList.map<Icons>((e) => Icons.fromJson(e)).toList());

            status = IconStatus.IconFound;
            notifyListeners();
          }
        }).catchError((e) {
          status = IconStatus.IconError;
          notifyListeners();
        });
      }
    } catch (e) {
      status = IconStatus.IconError;
      notifyListeners();
    }
  }

  // requestPermission() async {
  //   Map<Permission, PermissionStatus> statuses = await [
  //     Permission.storage,
  //   ].request();

  //   final info = statuses[Permission.storage].toString();
  //   print(info);
  // }
}
