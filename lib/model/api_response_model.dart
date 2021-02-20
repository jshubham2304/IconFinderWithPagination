import 'package:meta/meta.dart';

class ApiResponseModel {
  final String message;
  final bool isSuccess;
  var data;

  ApiResponseModel({
    @required this.message,
    @required this.isSuccess,
    this.data,
  });
}