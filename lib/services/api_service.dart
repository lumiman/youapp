import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youapp/models/chanel_details_model.dart';
import 'package:youapp/models/chanel_model.dart';
import 'package:youapp/models/video_model.dart';
import 'package:youapp/utils/constants.dart';

class APIService {

  Future<List<VideoModel>> getVideos() async {
    List<VideoModel> videosModel = [];
    String _path =
        "$pathProduction/search?part=snippet&key=$apiKey&maxResults=10&regionCode=PE";
    Uri _uri = Uri.parse(_path);

    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = json.decode(response.body);
      List videos = myMap["items"];
      videosModel = videos.map((e) => VideoModel.fromJson(e)).toList();
      return videosModel;
    }
    return videosModel;
  }

  Future<List<ChanelModel>> getChanel(String chanelId) async{
    List<ChanelModel> chanelModel = [];
    String _url = "$pathProduction/channels?part=snippet&id=$chanelId&key=$apiKey";
    Uri _uri = Uri.parse(_url);
    http.Response _response = await http.get(_uri);
    if (_response.statusCode == 200) {
      Map<String, dynamic> chanelMap = json.decode(_response.body);
      List chanel = chanelMap["items"];
      chanelModel = chanel.map((e) => ChanelModel.fromJson(e)).toList();
      return chanelModel;
    }
    return chanelModel;
  }

  Future<List<ChanelDetailsModel>> getChanelDetails(String chanelId) async{
    List<ChanelDetailsModel> chanelDetailsModel = [];
    String _url = "$pathProduction/channels?part=statistics,brandingSettings,snippet&id=$chanelId&key=$apiKey";
    Uri _uri = Uri.parse(_url);
    http.Response _response = await http.get(_uri);
    if (_response.statusCode == 200) {
      Map<String, dynamic> chanelMap = json.decode(_response.body);
      List chanel = chanelMap["items"];
      chanelDetailsModel = chanel.map((e) => ChanelDetailsModel.fromJson(e)).toList();
      return chanelDetailsModel;
    }
    return chanelDetailsModel;
  }

}
