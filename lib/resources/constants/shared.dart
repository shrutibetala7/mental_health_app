import 'package:flutter/material.dart';

var inputFieldDecoration = new InputDecoration(
  filled: true,
  fillColor: Colors.white60,
  contentPadding: EdgeInsets.all(6.0),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(width: 2.0, color: Colors.white)),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(width: 2.0, color: Colors.pink)),
);

var outlinedInputBorder = new OutlineInputBorder(
  borderRadius: BorderRadius.circular(20),
  borderSide: BorderSide(width: 2.0, color: Colors.black),
);
