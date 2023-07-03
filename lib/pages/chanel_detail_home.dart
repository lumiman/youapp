import 'package:flutter/material.dart';
import 'package:youapp/ui/general/colors.dart';

import '../models/chanel_details_model.dart' as cdm;
import '../models/video_model.dart';
import '../services/api_service.dart';
import '../ui/widgets/item_vide_widget.dart';

class ChanelDetailHome extends StatefulWidget {
  VideoModel videoModel;

  ChanelDetailHome({required this.videoModel});

  @override
  State<ChanelDetailHome> createState() => _ChanelDetailHomeState();
}

class _ChanelDetailHomeState extends State<ChanelDetailHome> {

  final APIService _apiService = APIService();
  List<VideoModel> videos = [];
  List<cdm.ChanelDetailsModel> chanel = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChanelData();
    getData();
  }

  getData() {
    _apiService.getVideos().then((value) {
      videos = value;
      setState(() {});
    });
  }

  getChanelData() {
    _apiService.getChanelDetails(widget.videoModel.snippet.channelId).then((value) {
      if (value != null) {
        isLoading = false;
        chanel = value;
        setState(() {});
      }
    });
  }

  String formatNumber(int number) {
    if (number >= 1000000) {
      double result = number / 1000000;
      return result.toStringAsFixed(0) + " M";
    } else if (number >= 1000) {
      double result = number / 1000;
      return result.toStringAsFixed(0) + " K";
    } else {
      return number.toString();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBrandPrimaryColor,
      body: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            child: Image.network(
              chanel[0].brandingSettings.image.bannerExternalUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.0,),
          CircleAvatar(
            backgroundColor: KBrandPrimaryColor,
            backgroundImage: NetworkImage(
              chanel[0].snippet.thumbnails.thumbnailsDefault.url,
            ),
          ),
          SizedBox(height: 16.0,),
          Text(
            chanel[0].snippet.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.0,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "SUBSCRITO",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                width: 6.0,
              ),
              Icon(
                Icons.notifications_none,
                color: Colors.white70,
                size: 20.0,
              )
            ],
          ),
          SizedBox(height: 16.0,),
          Text(
            '${formatNumber(int.parse(chanel[0].statistics.subscriberCount))} subscriptores · ${chanel[0].statistics.videoCount} videos',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white54,
            ),
          ),
          SizedBox(height: 16.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 350,
                child: Text(
                  chanel[0].snippet.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 13.0,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.white54,
                size: 16.0,
              ),
            ],
          ),
          SizedBox(height: 16.0,),
          Expanded( 
            child: SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: videos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemVideoWidget(
                      videoModel: videos[index],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
