import 'package:flutter/material.dart';

import 'home_tabs/favourite.dart';
import 'home_tabs/popular.dart';
class HeadLineNews extends StatefulWidget {
  @override
  _HeadLineNewsState createState() => _HeadLineNewsState();
}

class _HeadLineNewsState extends State<HeadLineNews>  with TickerProviderStateMixin{

  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController=TabController( initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: false,
        title: Text('Headline News'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white ,
          tabs: [
            Tab(
              text: 'WHAT`S NEW ',
            ),
            Tab(
              text: 'POPULAR',
            ),
            Tab(
              text: 'FAVOURITE',
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: Center(
        child: TabBarView(children: [
          Favourite(),
          Popular(),
          Favourite(),



        ] , controller: _tabController, ),
      ),
    );
  }
}
