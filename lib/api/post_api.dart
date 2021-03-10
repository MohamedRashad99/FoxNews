import 'package:http/http.dart' as http;
import 'dart:convert';


import '../utilities/api_utilities.dart';
import '../models/post.dart';

class PostsAPI {
  Future<List<Post>> fetchWhatsNew() async {
    List<Post> posts = List<Post>();
    String whatsNewApi = base_api + whats_new_api;
    var response = await http.get(whatsNewApi);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];
      for (var item in data) {
        Post post = Post(
          title: item['title'].toString(),
          description: item['description'].toString(),
          publishedAt: item['publishedAt'].toString(),
          urlToImage: item['urlToImage'].toString(),
          // author: ( item['author'] == null ) ? List<int>() : jsonDecode(item['author'])
          author: item['author'].toString(),
        );
        posts.add(post);
      }
    }
    return posts;
  }

  Future<List<Post>> fetchrecentUpdate() async {
    List<Post> posts = List<Post>();
    String whatsNewApi = base_api + recent_update_api;
    var response = await http.get(whatsNewApi);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];
      for (var item in data) {
        Post post = Post(
          title: item['title'].toString(),
          description: item['description'].toString(),
          publishedAt: item['publishedAt'].toString(),
          urlToImage: item['urlToImage'].toString(),
          // author: ( item['author'] == null ) ? List<int>() : jsonDecode(item['author'])
          author: item['author'].toString(),
        );
        posts.add(post);
      }
    }
    return posts;
  }

  Future<List<Post>> fetchPopular() async {
    List<Post> posts = List<Post>();
    String whatsNewApi = base_api + popular_posts_api;
    var response = await http.get(whatsNewApi);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data = jsonData["articles"];
      for (var item in data) {
        Post post = Post(
          title: item['title'].toString(),
          description: item['description'].toString(),
          publishedAt: item['publishedAt'].toString(),
          urlToImage: item['urlToImage'].toString(),
          // author: ( item['author'] == null ) ? List<int>() : jsonDecode(item['author'])
          author: item['author'].toString(),
        );
        posts.add(post);
      }
    }
    return posts;
  }
}
