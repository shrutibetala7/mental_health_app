import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:well_being_app/resources/constants/apiKey.dart';
import 'nearby.dart';

class NearbyLocation {
  static NearbyLocation _location;
  NearbyLocation._();

  static NearbyLocation get instance {
    if (_location == null) {
      _location = NearbyLocation._();
    }
    return _location;
  }

  Future<List<Nearby>> getNearby(
      {GeoPoint userLocation,
      double radius,
      String type,
      String keyword}) async {
    Uri url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${userLocation.latitude},${userLocation.longitude}&radius=$radius&type=$type&keyword=$keyword&key=AIzaSyDK3xs6fjCdp-iHygcnGPiY3Hbf9eDkIbM'
            as Uri;
    http.Response response = await http.get(url);
    final values = jsonDecode(response.body);
    final List result = values['results'];
    print(result);
    return result.map((e) => Nearby.fromJson(e)).toList();
  }
}
