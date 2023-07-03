import 'package:flutter/material.dart';
import 'package:youapp/pages/chanel_page.dart';
import 'package:youapp/ui/general/colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/video_model.dart';
import '../services/api_service.dart';
import '../ui/widgets/item_vide_widget.dart';
import '../ui/widgets/item_video_detail_widget.dart';

class VideoDetailPage extends StatefulWidget {
  String videoId;
  VideoModel videoModel;

  VideoDetailPage({required this.videoId, required this.videoModel});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  APIService _apiService = APIService();
  List<VideoModel> videos = [];
  bool isLoading = true;

  getData() {
    _apiService.getVideos().then((value) {
      videos = value;
      isLoading = false;
      setState(() {});
    });
  }

  late YoutubePlayerController _playerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playerController = YoutubePlayerController(
        initialVideoId: widget.videoId,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          hideControls: false,
        ));
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: KBrandPrimaryColor,
      body: Column(
        children: [
          SizedBox(
            height: height * 0.35,
            child: YoutubePlayer(
              controller: _playerController,
              progressColors: ProgressBarColors(
                  playedColor: Colors.red,
                  handleColor: Colors.red,
                  bufferedColor: Colors.white54,
                  backgroundColor: Colors.white.withOpacity(0.1)),
            ),
          ),
          ListTile(
            title: Text(
              'titulo',
              style: TextStyle(
                height: 1.3,
                color: Colors.white,
                fontSize: 14.0,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              '6.5 M de vistas · hace 2 anios',
              style: TextStyle(
                fontSize: 13.0,
                color: Colors.white54,
              ),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ItemVideoDetailWidget(
                          text: "53 K",
                          icon: Icons.thumb_up_alt_outlined,
                        ),
                        ItemVideoDetailWidget(
                          text: "No me gusta",
                          icon: Icons.thumb_down_alt_outlined,
                        ),
                        ItemVideoDetailWidget(
                          text: "Compartir",
                          icon: Icons.share,
                        ),
                        ItemVideoDetailWidget(
                          text: "Crear",
                          icon: Icons.play_arrow_rounded,
                        ),
                        ItemVideoDetailWidget(
                          text: "Descargar",
                          icon: Icons.download_rounded,
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.white24,
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChanelPage(videoModel: widget.videoModel),
                      ),
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.white24,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/320617/pexels-photo-320617.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  ),
                  title: Text(
                    "titulo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  subtitle: Text(
                    "1.43 M de susbscriptores",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "SUBSCRITO",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14.0,
                        ),
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Icon(
                        Icons.notifications_none,
                        color: Colors.white70,
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: Colors.white24,
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Comentarios',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        '2.9 K',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white54,
                        ),
                      ),
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: Colors.white,
                        size: 18.0,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 18.0,
                      ),
                    ],
                  ),
                ),
                ListTile(
                  minLeadingWidth: 10.0,
                  leading: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white24,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/320617/pexels-photo-320617.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  ),
                  title: Text(
                    "comentario de una persona con susbcription a youtube como ejemplo para este widget",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                !isLoading
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: videos.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemVideoWidget(
                            videoModel: videos[index],
                          );
                        })
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
