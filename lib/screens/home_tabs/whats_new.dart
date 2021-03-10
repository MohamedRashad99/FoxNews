import 'dart:math';

import '../../models/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:container/api/post_api.dart';
import 'package:flutter/widgets.dart';

import '../../utilities/data_utilities.dart';
import '../single_post.dart';

class WhatsNew extends StatefulWidget {
  @override
  _WhatsNewState createState() => _WhatsNewState();
}

class _WhatsNewState extends State<WhatsNew> {
  PostsAPI postsAPI = PostsAPI();

  TextStyle _headerTitle = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );
  TextStyle _headerDiscription = TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _drawheader(),
          _drawTopStories(),
          _drawRecentUpdates(),
        ],
      ),
    );
  }

  Widget _drawheader() {
    return FutureBuilder(
      future: postsAPI.fetchWhatsNew(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.none:
            // TODO handle problem
            return connectionerror();
            break;
          case ConnectionState.done:
            if (snapshot.error != null) {
              return error(snapshot.error);
            } else {
              List<Post> posts = snapshot.data;
              Random random = Random();
              int randomIndex = random.nextInt(posts.length);
              Post post = posts[randomIndex];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SinglePost(post);
                  }));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                //  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(post.urlToImage),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:20,bottom: 20),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 48, right: 48),
                            child: Text(
                              post.title,
                              style: _headerTitle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 34, right: 34),
                            child: Text(
                              post.description.substring(0, 50),
                              style: _headerDiscription,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            break;
        }
        return Container();

      },
    );
  }

  Widget _drawTopStories() {
    return Container(
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: _drawSectionTitles('Top Stroies'),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: FutureBuilder(
                future: postsAPI.fetchWhatsNew(),
                builder: (context, AsyncSnapshot snapShot) {
                  switch (snapShot.connectionState) {
                    case ConnectionState.waiting:
                      return loading();
                      break;
                    case ConnectionState.active:
                      return loading();
                      break;
                    case ConnectionState.none:
                      // TODO handle problem
                      return connectionerror();
                      break;
                    case ConnectionState.done:
                      if (snapShot.error != null) {
                        // TODO handle Error
                        return error(snapShot.error);
                      } else {
                        if (snapShot.hasData) {
                          List<Post> posts = snapShot.data;
                          if (posts.length >= 3) {
                            Post post1 = snapShot.data[0];
                            Post post2 = snapShot.data[1];
                            Post post3 = snapShot.data[2];
                            return Column(
                              children: <Widget>[
                                _drawSingleRow(post1),
                                _drawDivider(),
                                _drawSingleRow(post2),
                                _drawDivider(),
                                _drawSingleRow(post3),
                              ],
                            );
                          } else {
                            return noData();
                          }
                        } else {
                          //TODO : handle No Data
                          return noData();
                        }
                      }
                      break;
                  } // switch
                 return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawRecentUpdates() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
          future: postsAPI.fetchrecentUpdate(),
          builder: (context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return connectionerror();
                break;
              case ConnectionState.active:
                return loading();
                break;
              case ConnectionState.waiting:
                return loading();
                break;
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return error(snapshot.error);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                        child: _drawSectionTitles('Recent Update'),
                      ),
                      _drawRecentUpdateCard(
                          Colors.deepOrange, snapshot.data[0]),
                      _drawRecentUpdateCard(Colors.teal, snapshot.data[1]),
                      SizedBox(
                        height: 48,
                      ),
                    ],
                  );
                }
                break;
            }
          return Container();
          }),
    );
  }

  Widget _drawSingleRow(Post post) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SinglePost(post);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.network(
              post.urlToImage,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
       SizedBox(width: 6),
            Container(
              width: MediaQuery.of(context).size.width - 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5,bottom: 5),
                    child: Text(post.author),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.timer),
                      SizedBox(width: 6,),
                      Text(
                        parseHumanDateTime(post.publishedAt),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawDivider() {
    return Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey.shade300,
    );
  }

  Widget _drawSectionTitles(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.grey.shade700,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    );
  }

  Widget _drawRecentUpdateCard(Color color, Post post) {
    return Card(
        child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SinglePost(post);
        }));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(post.urlToImage), fit: BoxFit.cover),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
            ),
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 2,
                bottom: 2,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'SPORT',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 8,
            ),
            child: Text(
              post.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 16,
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.timer,
                  color: Colors.grey,
                  size: 18,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  parseHumanDateTime(post.publishedAt),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
