import 'package:iconfinder/enums/response_enums.dart';
import 'package:meta/meta.dart';

class ApiResponseModel {
  final String message;
  final ResponseStatus status;
  var data;

  ApiResponseModel({
    @required this.message,
    @required this.status,
    this.data,
  });
}
