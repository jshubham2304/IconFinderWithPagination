import 'package:http/http.dart' as http;
import 'package:iconfinder/model/category.dart';
import 'package:iconfinder/response_handler/reponse_handler.dart';
import 'package:iconfinder/utils/api_urls.dart';

abstract class ApiService {
  ApiService._();
  static Map<String, String> header = {
    'Authorization':
        'Bearer X0vjEUN6KRlxbp2DoUkyHeM0VOmxY91rA6BbU5j3Xu6wDodwS0McmilLPBWDUcJ1'
  };

  static Future<dynamic> getCategory({Category lastCategory}) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        ApiUrls.baseUrls +
            ApiUrls.categoryEndPoint +
            ApiUrls.count10 +
            '${lastCategory != null ? ApiUrls.afterStringPoint + lastCategory.identifier : ''}'
                .trim(),
        headers: header,
      );
      print(response.body);
      responseJson = ResponseHandler.returnResponse(response);
    } catch (e) {
      rethrow;
    }

    return responseJson;
  }

  Future<dynamic> getIcons(String identifier) async {
    dynamic responseJson;
    try {
      final response = await http.get(
          ApiUrls.baseUrls +
              ApiUrls.categoryEndPoint +
              identifier +
              ApiUrls.iconEndPoint,
          headers: header);
      responseJson = ResponseHandler.returnResponse(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  static Future<Map> getIconSets(String category, String iconSetId) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        ApiUrls.baseUrls +
            ApiUrls.categoryEndPoint +
            '/' +
            category +
            ApiUrls.iconEndPoint +
            ApiUrls.count10 +
            '${iconSetId != null ? ApiUrls.afterStringPoint + iconSetId : ''}'
                .trim(),
        headers: header,
      );

      responseJson = ResponseHandler.returnResponse(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  static Future<dynamic> getIcon(String id, {int nextPage = 0}) async {
    dynamic responseJson;
    try {
      print(ApiUrls.iconEndPoint +
          '/' +
          id +
          ApiUrls.iconMainEndPoint +
          ApiUrls.count10 +
          '${nextPage != 0 ? '&offset=' + nextPage.toString() : ''}'.trim());
      final response = await http.get(
        ApiUrls.baseUrls +
            ApiUrls.iconEndPoint +
            '/' +
            id +
            ApiUrls.iconMainEndPoint +
            ApiUrls.count10 +
            '${nextPage != 0 ? '&offset=' + nextPage.toString() : ''}'.trim(),
        headers: header,
      );
      print(response.body);
      responseJson = ResponseHandler.returnResponse(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  static Future<dynamic> searchIcon(String key, {int nextPage = 0}) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        ApiUrls.baseUrls +
            ApiUrls.searchIconPoint +
            key +
            '&count=20' +
            '${nextPage != 0 ? '&offset=' + nextPage.toString() : ''}'.trim(),
        headers: header,
      );
      responseJson = ResponseHandler.returnResponse(response);
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }
}
