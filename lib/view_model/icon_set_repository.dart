// import 'package:flutter/cupertino.dart';
// import 'package:iconfinder/api/api_service.dart';
// import 'package:iconfinder/model/icon.dart';
// import 'package:iconfinder/model/icon_set.dart';

// enum IconStatus { IconProcessing, IconFound, IconError, IconNoFound }

// class IconSetRepository extends ChangeNotifier {
//   List<Iconsets> iconSets;

//   Iconsets nextIconsets;

//   List<Iconsets> iconsetsList = [];
//   String errorMessage = '';
//   IconStatus status = IconStatus.IconProcessing;

//   void getIconsetsData(String category, {bool isNext = false}) {
//     try {
//       status = IconStatus.IconProcessing;
//       notifyListeners();

//       ApiService.getIconsets(category, isNext ? nextIconsets : null)
//           .then((response) {
//         if (response != null) {
//           var data = response['iconsets'] as List;

//           if (isNext) {
//             List<Iconsets> list = [];
//             data
//                 .map<Iconsets>((e) => Iconsets.fromJson(e))
//                 .toList()
//                 .forEach((element) {
//               //print(element);
//               ApiService.getIcon(
//                 element.iconsetId.toString(),
//                 count: 4,
//               ).then((value) {
//                 if (value != null) {
//                   var jsonList = value['icons'] as List;
//                   element.icons =
//                       jsonList.map<Icons>((e) => Icons.fromJson(e)).toList();
//                   //print(element.icons.length);
//                 }
//               }).catchError((e) {});
//               list.add(element);
//             });
//             iconsetsList.addAll(list);
//           } else {
//             data
//                 .map<Iconsets>((e) => Iconsets.fromJson(e))
//                 .toList()
//                 .forEach((element) async {
//               await ApiService.getIcon(element.iconsetId.toString(), count: 4)
//                   .then((value) {
//                 if (value != null) {
//                   var jsonList = value['icons'] as List;
//                   element.icons =
//                       jsonList.map<Icons>((e) => Icons.fromJson(e)).toList();
//                   iconsetsList.add(element);
//                 }
//               }).catchError((e) {});
//             });
//           }
//           nextIconsets = iconsetsList.last;
//           status = IconStatus.IconFound;
//           notifyListeners();
//         } else {
//           status = IconStatus.IconNoFound;
//           errorMessage = 'No Iconsets Found';
//           notifyListeners();
//         }
//       }).catchError((e) {
//         errorMessage = e.toString();
//         status = IconStatus.IconError;
//         notifyListeners();
//       });
//     } catch (e) {
//       errorMessage = e;
//       status = IconStatus.IconError;
//       notifyListeners();
//     }
//   }
// }
