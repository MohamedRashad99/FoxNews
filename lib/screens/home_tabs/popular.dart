import 'package:container/screens/single_post.dart';
import 'package:flutter/material.dart';
import 'package:container/api/post_api.dart';
import 'dart:async';
import 'package:container/models/post.dart';
import 'package:container/utilities/data_utilities.dart';

class Popular extends StatefulWidget {
  @override
  _PopularState createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  PostsAPI postsAPI = PostsAPI();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsAPI.fetchPopular(),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return connectionerror();
            break;
          case ConnectionState.waiting:
            return loading();
            break;
          case ConnectionState.active:
            return loading();
            break;
          case ConnectionState.done:
            if (snapshot.hasError) {
              return error(snapshot.error);
            } else {
              List<Post> posts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, position) {
                  return Card(
                    child: _drawSingleRow(posts[position]),
                  );
                },
                itemCount: posts.length,
              );
            }
            break;
        }
        /*                  ----------------------    hena error ---------------------------*/
        return ListView.builder(
          itemBuilder: (context, position) {
            return Card(
              child: _drawSingleRow(null),
            );
          },
          itemCount: 20,
        );
      },
    );
  }

  Widget _drawSingleRow(Post post) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SinglePost(post);
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              child: Image(
                image: NetworkImage(post.urlToImage),
                fit: BoxFit.cover,
              ),
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    post.title,
                    maxLines: 9,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
