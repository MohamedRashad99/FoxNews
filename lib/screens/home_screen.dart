import 'package:flutter/material.dart';


import '../shared_ui/navigation_drawer.dart';
import 'home_tabs/whats_new.dart';
import 'home_tabs/popular.dart';
import 'home_tabs/favourite.dart';
import '../api/post_api.dart';
import 'pages/about.dart';
import 'pages/contact.dart';
import 'pages/help.dart';
import 'pages/settings.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

enum PopOutMenu { HELP, ABOUT, CONTACT, SETTING }

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
    //AuthorsAPI authorsAPI = AuthorsAPI();
    //CategoriesAPI categoriesAPI = CategoriesAPI();
    PostsAPI postsAPI = PostsAPI();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    //authorsAPI.fetchAllAuthers();
    //categoriesAPI.fetchCategories();
      postsAPI.fetchWhatsNew();
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(
        centerTitle: false,
        title: Text('Explore'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          _popOutMenu(context),
        ],
        bottom: TabBar(
          indicatorColor: Colors.white,
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
        child: TabBarView(
          children: [
            WhatsNew(),
            Popular(),
            Favourite(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }

  Widget _popOutMenu(BuildContext context) {
    return PopupMenuButton<PopOutMenu>(
      itemBuilder: (context) {
        return [
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.ABOUT,
            child: Text('ABOUT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.CONTACT,
            child: Text('CONTACT'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.HELP,
            child: Text('HELP'),
          ),
          PopupMenuItem<PopOutMenu>(
            value: PopOutMenu.SETTING,
            child: Text('SETTING'),
          ),
        ];
      },
      onSelected: (PopOutMenu menu) {
        switch(menu){
          case PopOutMenu.ABOUT:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return AboutUs();
            }));
            break;
          case PopOutMenu.SETTING:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Settings();
            }));
            break;
          case PopOutMenu.CONTACT:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ContactUs();
            }));
            break;
          case PopOutMenu.HELP:
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Help();
            }));
            break;
        }
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
