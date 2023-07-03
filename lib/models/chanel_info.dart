import 'package:flutter/material.dart';
import 'package:youapp/models/video_model.dart';

import '../services/api_service.dart';
import '../ui/general/colors.dart';
import 'chanel_details_model.dart';

class ChanelInfo extends StatefulWidget {
  VideoModel videoModel;

  ChanelInfo({required this.videoModel});

  @override
  State<ChanelInfo> createState() => _ChanelInfoState();
}

class _ChanelInfoState extends State<ChanelInfo> {
  final APIService _apiService = APIService();
  List<ChanelDetailsModel> chanel = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChanelData();
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

  getChanelData() {
    _apiService
        .getChanelDetails(widget.videoModel.snippet.channelId)
        .then((value) {
      isLoading = false;
      chanel = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBrandPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descripcion',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              chanel[0].snippet.description,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              'Vinculos',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.blur_circular,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'web',
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.facebook,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Facebook',
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.blur_circular,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Twitter',
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.blur_circular,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Instagram',
                  style: TextStyle(color: Colors.blueAccent),
                )
              ],
            ),
            SizedBox(
              height: 24.0,
            ),
            Text(
              'Mas Informacion',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.blur_circular,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'http://www.youtube.com',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ],
            ),
            Visibility(
              visible: chanel[0].brandingSettings.channel.country != null,
              child: SizedBox(
                height: 16.0,
              ),
            ),
            Visibility(
              visible: chanel[0].brandingSettings.channel.country != null,
              child: Row(
                children: [
                  Icon(
                    Icons.blur_circular,
                    color: Colors.white70,
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                     chanel[0].brandingSettings.channel.country.toString(),
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Se unio el 29 Jun 2012',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.area_chart_rounded,
                  color: Colors.white70,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  '${formatNumber(int.parse(chanel[0].statistics.viewCount))} vistas',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
