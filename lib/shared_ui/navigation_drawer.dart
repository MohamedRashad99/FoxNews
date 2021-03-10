import 'package:flutter/material.dart';


import '../screens/twitter_feed.dart';
import '../models/nav_menu.dart';
import '../screens/home_screen.dart';
import '../screens/headline_news.dart';
import '../screens/instagram_feed.dart';
import '../screens/facebook_feeds.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  List<NavMnueItem>navgationMenu=[
    NavMnueItem('Explore' , () {return HomeScreen();} ),
    NavMnueItem('Head Line News', () => HeadLineNews()),
    NavMnueItem('Twitter Feeds ', () => TwitterFeed()),
    NavMnueItem('Instagram Feeds ', () => InstagramFeed()),
    NavMnueItem('Facebook Feeds ', () => FacebookFeed()),
  ];
  List<String>navMenu=[
    'Explore',
    'HeadLine',
    'Read Later',
    'Videos',
    'Setting',
    'Logout'
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(left: 24 ,top: 75),
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  navgationMenu[position].title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 22,
                  ),
                ),
                trailing: Icon(Icons.chevron_right,
                  color: Colors.grey.shade400,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return navgationMenu[position].distination();
                  }));
                },

              ),
            );
          },
          itemCount: navgationMenu.length,
        ),
      ),
    );
  }
}
