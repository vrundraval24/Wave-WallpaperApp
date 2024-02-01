import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wave/Constants/secrets/keys.dart';
import 'package:wave/model/photo_model.dart';

class API{

  static List<PhotoModel> listOfPhotos = [];
  static List<PhotoModel> listOfSearchedPhotos = [];

  static const int _numberOfPages = 80;


  static Future<List<PhotoModel>> getTrendingWallpapers() async{

    await http.get(
        Uri.parse('https://api.pexels.com/v1/curated?per_page=$_numberOfPages'),
        headers: {'Authorization' : SecretKeys.authorizationKey},
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);

      List photosList = jsonData['photos'];

      for (var element in photosList) {
        listOfPhotos.add(PhotoModel.fromJson(element));

      }

    });

    return listOfPhotos;

  }


  static Future<List<PhotoModel>> searchedWallpapers(String query) async{

    await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
      headers: {'Authorization' : SecretKeys.authorizationKey},
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);

      List photosList = jsonData['photos'];
      listOfSearchedPhotos.clear();

      for (var element in photosList) {
        listOfSearchedPhotos.add(PhotoModel.fromJson(element));

      }

    });

    return listOfSearchedPhotos;

  }


  static Future<List<PhotoModel>> loadMoreWallpapers(pageNumber) async{

    await http.get(
      Uri.parse('https://api.pexels.com/v1/curated?per_page=$_numberOfPages&page=$pageNumber'),
      headers: {'Authorization' : SecretKeys.authorizationKey},
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);

      List photosList = jsonData['photos'];

      for (var element in photosList) {
        listOfPhotos.add(PhotoModel.fromJson(element));

      }

    });

    return listOfPhotos;

  }


  static Future<List<PhotoModel>> loadMoreSearchedWallpapers(String query) async{

    await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
      headers: {'Authorization' : SecretKeys.authorizationKey},
    ).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);

      List photosList = jsonData['photos'];
      listOfSearchedPhotos.clear();

      for (var element in photosList) {
        listOfSearchedPhotos.add(PhotoModel.fromJson(element));

      }

    });

    return listOfSearchedPhotos;

  }
}