import 'package:flutter/material.dart';

class PageModel {
  String _title;
  String _discriptions;
  String _images;
  IconData _icon;

  PageModel(this._title, this._discriptions, this._images, this._icon);

  IconData get icon => _icon;

  set icon(IconData value) {
    _icon = value;
  }

  String get images => _images;

  set images(String value) {
    _images = value;
  }

  String get discriptions => _discriptions;

  set discriptions(String value) {
    _discriptions = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}
