import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget loading() {
  return Container(
    padding: EdgeInsets.only(top: 16 ,bottom: 16),
    child: Center(
      child: CircularProgressIndicator(),
    ),
  );
}

Widget connectionerror(){
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('Connection Error !!'),
  );
}

Widget error(var error){
  return Container(
    padding: EdgeInsets.all(16),
    child: Text(error.toString()),
  );
}

Widget noData(){
  return Container(
    padding: EdgeInsets.all(16),
    child: Text('NO Data Available '),
  );
}
String parseHumanDateTime( String dateTime ){

  Duration timeAge  = DateTime.now().difference(DateTime.parse(dateTime) );

  DateTime theDifference = DateTime.now().subtract(timeAge);

  return timeago.format(theDifference) ;
}