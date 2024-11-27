import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:weather_forcast/api/api_client.dart';
import 'package:weather_forcast/api/api_url.dart';

import '../features/home/model/forecast_model.dart';
import '../features/search/model/places_model.dart';

class ApiRepo {
  static ApiClient apiClient = ApiClient();
  static String baseUrl = dotenv.env['base_url'] ?? "";
  static String key = dotenv.env['key'] ?? "";

  static Future<ForecastModel> getForecasting(String placeName) async {
    try {
      Response response = await apiClient.get(Uri.https(
          baseUrl, ApiUrl.currentForecast, {'q': placeName, 'key': key}));
      print(response.body);
      return ForecastModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw 'error $e';
    }
  }

  static Future getFutureForecasting(
      String placeName, DateTime date) async {
    try {
      Response response = await apiClient.get(Uri.https(
          baseUrl, ApiUrl.futureForecast, {
        'q': placeName,
        'key': key,
        'dt': '${date.year}-${date.month}-${date.day}'
      }));
      print(response.body);
      return response.body;
    } catch (e) {
      throw 'error $e';
    }
  }

  static Future<PlacesModel> getPlaceSearch(String placeName) async {
    try {
      Response response = await apiClient.get(Uri.https(
          baseUrl, ApiUrl.searchPlaces, {'q': placeName, 'key': key}));
      print(response.body);
      return PlacesModel.fromJson({"places": jsonDecode(response.body)});
    } catch (e) {
      return PlacesModel(places: []);
    }
  }
}
