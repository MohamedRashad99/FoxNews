import 'dart:math';

import 'package:container/api/post_api.dart';
import 'package:container/models/post.dart';
import 'package:container/utilities/data_utilities.dart';
import 'package:flutter/material.dart';
import 'package:container/shared_ui/navigation_drawer.dart';

class TwitterFeed extends StatefulWidget {
  @override
  _TwitterFeedState createState() => _TwitterFeedState();
}

class _TwitterFeedState extends State<TwitterFeed> {
  PostsAPI postsAPI = PostsAPI();
  List<int>ids=[0,2,7];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Twitter Feeds',
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      drawer: NavigationDrawer(),
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              child: Column(
                children: [
                  _cardHeader(position),
                  _cardBody(position),
                  _drawLine(),
                  _cardFooter(position),
                ],
              ),
            ),
          );
        },
        itemCount: 20,
      ),
    );
  }

  Widget _cardHeader(int position) {
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
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(post.urlToImage),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.author,
                            style: TextStyle(
                              color: Colors.grey.shade900,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '@ch_mayers',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(post.publishedAt),
                    ],
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

  Widget _cardBody(int position) {
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
              return Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Text(
                 post.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade900,
                    height: 1.2,
                  ),
                ),
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

  Widget _cardFooter(int position) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.repeat,
                  size: 28,
                ),
                color: (ids.contains(position)) ? Colors.red : Colors.orange,
                onPressed: () {
                  if(ids.contains(position)){
                    ids.remove(position);
                  }else{
                    ids.add(position);
                  }
                  setState(() {

                  });
                  print(ids);

                },
              ),
              Text(
                '25',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Row(
            children: [
              FlatButton(
                onPressed: () {},
                child: Text(
                  'SHARE',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  'OPEN',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 Widget _drawLine() {
    return Container(
      height: 1,
      color: Colors.grey.shade200,
      margin: EdgeInsets.only(top: 16),
    );
 }
}
