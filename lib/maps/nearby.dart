// To parse this JSON data, do
//
//     final nearby = nearbyFromJson(jsonString);

import 'dart:convert';

Nearby nearbyFromJson(String str) => Nearby.fromJson(json.decode(str));

String nearbyToJson(Nearby data) => json.encode(data.toJson());

class Nearby {
  Nearby({
    this.htmlAttributions,
    this.results,
  });

  List<dynamic> htmlAttributions;
  List<Result> results;

  factory Nearby.fromJson(Map<String, dynamic> json) => Nearby(
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.geometry,
    this.icon,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.reference,
    this.types,
    this.vicinity,
  });

  Geometry geometry;
  String icon;
  String name;
  OpeningHours openingHours;
  List<Photo> photos;
  String placeId;
  String reference;
  List<String> types;
  String vicinity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        name: json["name"],
        openingHours: OpeningHours.fromJson(json["opening_hours"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        reference: json["reference"],
        types: List<String>.from(json["types"].map((x) => x)),
        vicinity: json["vicinity"],
      );

  Map<String, dynamic> toJson() => {
        "geometry": geometry.toJson(),
        "icon": icon,
        "name": name,
        "opening_hours": openingHours.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "reference": reference,
        "types": List<dynamic>.from(types.map((x) => x)),
        "vicinity": vicinity,
      };
}

class Geometry {
  Geometry({
    this.location,
  });

  Location location;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
      };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
      };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int height;
  List<dynamic> htmlAttributions;
  String photoReference;
  int width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        htmlAttributions:
            List<dynamic>.from(json["html_attributions"].map((x) => x)),
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
        "photo_reference": photoReference,
        "width": width,
      };
}
