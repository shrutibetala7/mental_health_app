import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';

class NearbyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NearbyWidgetState();
  }
}

class NearbyWidgetState extends State {
  TextEditingController locationController = TextEditingController();
  TextEditingController keywordController =
      TextEditingController(text: "Therapist");
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(25.321684, 82.987289),
    zoom: 14.0,
  );

  List<NearbyResult> result = [];

  bool isShowList = false;

  MapmyIndiaMapController controller;
  static const String MAP_SDK_KEY = "c747bb7412807edf1a35c91c0a782e8c";
  static const String REST_API_KEY = "c747bb7412807edf1a35c91c0a782e8c";
  static const String ATLAS_CLIENT_ID =
      "33OkryzDZsJUrV1hv9Zh1Gbz2qAR6rrlHmD9BOypvsVKBaeiROR1yAXJ7_RYmIxnIgBPuwFi04F24BGfTn3x6qGp7yBZWoxn";
  static const String ATLAS_CLIENT_SECRET =
      "lrFxI-iSEg9_GgEKYv3XaW2hSsm9u9pQkBcR9ECweg6M5xsywG_ODxQTRXcmWpWTXNM6L6oKz3LeQI3vKvPZP8s41b30Q2N_cJSwJn8lrNM=";
  Position location;
  @override
  void initState() {
    super.initState();

    MapmyIndiaAccountManager.setMapSDKKey(MAP_SDK_KEY);
    MapmyIndiaAccountManager.setRestAPIKey(REST_API_KEY);
    MapmyIndiaAccountManager.setAtlasClientId(ATLAS_CLIENT_ID);
    MapmyIndiaAccountManager.setAtlasClientSecret(ATLAS_CLIENT_SECRET);
    getLocation();
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      location = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text(
          'Nearby API',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.2, systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(children: <Widget>[
        MapmyIndiaMap(
          initialCameraPosition: _kInitialPosition,
          onMapCreated: (map) => {
            controller = map,
          },
          onMapLongClick: (point, latlng) => {
            locationController.text = '${latlng.latitude},${latlng.longitude}',
            nearby()
          },
        ),
        Container(
            padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Location:"),
                        flex: 1,
                      ),
                      Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: locationController,
                            decoration: InputDecoration(
                                hintText: "Lat,Lng", fillColor: Colors.white),
                          ))
                    ],
                  ),
                  // Row(children: [
                  //   Text("latitude :${location.latitude}"),
                  //   Text("longitude :${location.longitude}"),
                  // ]),
                  Row(
                    children: [
                      Expanded(child: Text("Keyword:"), flex: 1),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextFormField(
                            controller: keywordController,
                            decoration: InputDecoration(
                                hintText: "e.g.,Therapist",
                                fillColor: Colors.white),
                          ),
                          flex: 2)
                    ],
                  ),
                  TextButton(
                      onPressed: () => {
                            if (locationController.text.isNotEmpty &&
                                keywordController.text.isNotEmpty)
                              {nearby()}
                          },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.pinkAccent),
                          textStyle: MaterialStateProperty.all(
                              TextStyle(color: Colors.white))))
                ])),
        result.length > 0 && isShowList
            ? BottomSheet(
                onClosing: () => {},
                builder: (context) => Expanded(
                    child: ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return Container(
                              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.all(5),
                                focusColor: Colors.white,
                                title: Text(result[index].placeName ?? ''),
                                subtitle: Text(
                                  result[index].placeAddress ?? '',
                                  maxLines: 2,
                                ),
                              ));
                        })))
            : Container()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          setState(() {
            isShowList = !isShowList;
          })
        },
        child: isShowList ? Icon(Icons.map) : Icon(Icons.list),
      ),
    );
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return controller.addImage(name, list);
  }

  boundsFromLatLngList(List<LatLng> list) {
    assert(list.isNotEmpty);
    double x0, x1, y0, y1;
    for (LatLng latLng in list) {
      if (x0 == null || x1 == null || y0 == null || y1 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude > x1) x1 = latLng.latitude;
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.longitude > y1) y1 = latLng.longitude;
        if (latLng.longitude < y0) y0 = latLng.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1, y1), southwest: LatLng(x0, y0));
  }

  nearby() async {
    await addImageFromAsset("icon", "assets/symbols/custom-icon.png");
    await controller.clearSymbols();
    setState(() {
      result = [];
    });
    try {
      String location = locationController.text;
      print(location);
      if (location.contains(",")) {
        NearbyResponse nearbyResponse = await MapmyIndiaNearby(
          keyword: keywordController.text,
          location: LatLng(
            double.parse(location.split(",")[0]),
            double.parse(location.split(",")[1]),
          ),
        ).callNearby();
        getResponse(nearbyResponse);
      } else {
        NearbyResponse nearbyResponse = await MapmyIndiaNearby(
                keyword: keywordController.text, eLoc: location)
            .callNearby();
        getResponse(nearbyResponse);
      }
    } catch (e) {
      if (e is PlatformException) {
        Fluttertoast.showToast(msg: '${e.code} --- ${e.message}');
      }
    }
  }

  void getResponse(NearbyResponse nearbyResponse) {
    if (nearbyResponse != null &&
        nearbyResponse.suggestedLocations != null &&
        nearbyResponse.suggestedLocations.length > 0) {
      List<SymbolOptions> options = [];
      List<LatLng> latlngList = [];
      nearbyResponse.suggestedLocations?.forEach((element) {
        print(json.encode(element.toJson()));
        latlngList.add(LatLng(element.latitude, element.longitude));
        options.add(SymbolOptions(
            geometry: LatLng(element.latitude, element.longitude),
            iconImage: 'icon'));
      });
      setState(() {
        result = nearbyResponse.suggestedLocations;
      });
      controller.addSymbols(options);
      controller.animateCamera(CameraUpdate.newLatLngBounds(
          boundsFromLatLngList(latlngList),
          top: 40));
    }
  }
}
