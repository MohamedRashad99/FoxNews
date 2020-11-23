import 'dart:math';

import 'package:container/api/post_api.dart';
import 'package:container/models/post.dart';
import 'package:container/utilities/data_utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  PostsAPI postsAPI = PostsAPI();
  List<int>ids=[0,2,7];
  List<Color> colorslist = [
    Colors.red,
    Colors.deepOrange,
    Colors.teal,
    Colors.grey,
    Colors.deepPurple,
    Colors.amber,
  ];
  Random _random = Random();

  Color _getRondomColor() {
    return colorslist[_random.nextInt(colorslist.length)];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, positin) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                _outherRow(),
                SizedBox(height: 16),
                _newsItemRow(),
              ],
            ),
          ),
        );
      },
      itemCount: 20,
    );
  }

  Widget _outherRow() {
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:NetworkImage(post.urlToImage),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(right: 16),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width - 160,
                            child: Text(
                              post.author,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Text(
                                post.publishedAt,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'LifeStyle.',
                                style: TextStyle(
                                  color: _getRondomColor(),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark_border,
                    ),
                    onPressed: () {

                    },
                    color: Colors.grey,
                  )
                ],
              );
            }
            break;
        }
        return Container(
          color: Colors.red,
        );
      },
    );


  }

  Widget _newsItemRow() {
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
              return Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(post.urlToImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 124,
                    height: 124,
                    margin: EdgeInsets.only(right: 16),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          post.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                         post.description ,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            height: 1.25,
                            fontWeight: FontWeight.w600,
                          ),),
                      ],
                    ),
                  ),
                ],
              );

            }
            break;
        }
        return Container(
          color: Colors.red,
        );
      },
    );


  }
}
