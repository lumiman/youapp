import 'package:flutter/material.dart';
import 'package:youapp/models/chanel_model.dart';
import 'package:youapp/models/video_model.dart';
import 'package:youapp/pages/vide_detail_page.dart';

import '../../services/api_service.dart';

class ItemVideoWidget extends StatefulWidget {
  VideoModel videoModel;

  ItemVideoWidget({required this.videoModel});

  @override
  State<ItemVideoWidget> createState() => _ItemVideoWidgetState();
}

class _ItemVideoWidgetState extends State<ItemVideoWidget> {
  final APIService _apiService = APIService();

  List<ChanelModel> chanel = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChanelData();
  }

  getChanelData() {
    _apiService.getChanel(widget.videoModel.snippet.channelId).then((value) {
      if (value != null) {
        isLoading = false;
        chanel = value;
        setState(() {});
      }
    });
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoDetailPage(videoId: widget.videoModel.id.videoId, videoModel: widget.videoModel,),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            Stack(children: [
              Image.network(
                width: double.infinity,
                height: height * 0.3,
                fit: BoxFit.cover,
                widget.videoModel.snippet.thumbnails.high.url,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                    vertical: 2.0,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  color: Colors.black.withOpacity(0.7),
                  child: Text(
                    '23:32',
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
              )
            ]),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundColor: Colors.white12,
                backgroundImage: NetworkImage(
                  chanel[0].snippet.thumbnails.thumbnailsDefault.url,
                ),
              ),
              title: Text(
                widget.videoModel.snippet.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
              subtitle: Text(
                "${widget.videoModel.snippet.channelTitle} · 6.5 M de vistas · hace 2 anios",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13.0,
                ),
              ),
              trailing: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4.0),
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
