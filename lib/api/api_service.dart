import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iconfinder/model/category.dart';
import 'package:iconfinder/model/icon_set.dart';
import 'package:iconfinder/response_handler/reponse_handler.dart';
import 'package:iconfinder/utils/api_urls.dart';

import 'api_exception.dart';

abstract class ApiService {
  ApiService._();
  static Future<dynamic> getCategory(Category lastCategory) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          '${ApiUrls.baseUrls + ApiUrls.categoryEndPoint}${lastCategory != null ? ApiUrls.afterStringPoint + lastCategory.identifier : ''}'
              .trim(),
          headers: {
            'Authorization':
                'Bearer X0vjEUN6KRlxbp2DoUkyHeM0VOmxY91rA6BbU5j3Xu6wDodwS0McmilLPBWDUcJ1'
          });
      responseJson = ResponseHandler.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      rethrow;
    }

    return responseJson;
  }

  Future<dynamic> getIcons(String identifier) async {
    dynamic responseJson;
    try {
      final response = await http.get(ApiUrls.baseUrls +
          ApiUrls.categoryEndPoint +
          identifier +
          ApiUrls.iconEndPoint);
      responseJson = ResponseHandler.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  static Future<dynamic> getIconsets(String category, Iconsets iconsets) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          '${ApiUrls.baseUrls + ApiUrls.categoryEndPoint + "/" + category + ApiUrls.iconEndPoint + ApiUrls.count10}${iconsets != null ? ApiUrls.afterStringPoint + iconsets.iconsetId.toString() : ''}'
              .trim(),
          headers: {
            'Authorization':
                'Bearer X0vjEUN6KRlxbp2DoUkyHeM0VOmxY91rA6BbU5j3Xu6wDodwS0McmilLPBWDUcJ1'
          });

      responseJson = ResponseHandler.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  static getIcon(String id, {int count = 10, int nextpage = 0}) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          '${ApiUrls.baseUrls + ApiUrls.iconEndPoint + "/" + id + ApiUrls.iconMainEndPoint + ApiUrls.count10}${nextpage != 0 ? "&offset=" + nextpage.toString() : ''}'
              .trim(),
          headers: {
            'Authorization':
                'Bearer X0vjEUN6KRlxbp2DoUkyHeM0VOmxY91rA6BbU5j3Xu6wDodwS0McmilLPBWDUcJ1'
          });
      responseJson = ResponseHandler.returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }
}
