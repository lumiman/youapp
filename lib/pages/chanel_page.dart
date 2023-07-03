import 'package:flutter/material.dart';
import 'package:youapp/pages/chanel_detail_home.dart';
import 'package:youapp/ui/general/colors.dart';

import '../models/chanel_info.dart';
import '../models/video_model.dart';

class ChanelPage extends StatefulWidget {
  VideoModel videoModel;

  ChanelPage({required this.videoModel});

  @override
  State<ChanelPage> createState() => _ChanelPageState();
}

class _ChanelPageState extends State<ChanelPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBrandPrimaryColor,
      appBar: AppBar(
        backgroundColor: KBrandPrimaryColor,
        elevation: 0,
        title: Text("detalle canal"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.cast),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
            color: Colors.white,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorWeight: 2.7,
          tabs: [
            Tab(
              child: Text("PAGINA PRINCIPAL",style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("VIDEOS",style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("LISTA DE REPRODUCCION",style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("COMUNINDAD",style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("CANALES",style: TextStyle(fontSize: 16.0,),),
            ),
            Tab(
              child: Text("MAS INFORMACION",style: TextStyle(fontSize: 16.0,),),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ChanelDetailHome(videoModel: widget.videoModel),
          Center(child: Text('Pagina 2'),),
          Center(child: Text('Pagina 3'),),
          Center(child: Text('Pagina 4'),),
          Center(child: Text('Pagina 5'),),
          ChanelInfo(videoModel: widget.videoModel),
        ],
      ),
    );
  }
}
