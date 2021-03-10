import 'package:http/http.dart' as http;
import 'dart:convert';


import '../models/auther.dart';
import '../utilities/api_utilities.dart';

 class AuthorsAPI {
  Future< List<Author> > fetchAllAuthers() async {
   List<Author>authors =List<Author>();
     String allAuthorsApi = base_api + all_authors_api;

    var response = await http.get(allAuthorsApi);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var data =jsonData["articles"];
      for(var item in data){
       Author author =Author(
           item['title'].toString(),
           item['description'].toString(),
           item['publishedAt'].toString(),
           item['urlToImage'].toString() ,
           item['author'].toString());
       authors.add(author);
      }

    }
    return authors;
  }
}
