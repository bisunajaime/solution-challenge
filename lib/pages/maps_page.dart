import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/models/reliefcenter_model.dart';
import 'package:helpinghand/pages/moreinfo_page.dart';
import 'package:helpinghand/utils/data_utils.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:map_launcher/map_launcher.dart' as ml;
import 'package:url_launcher/url_launcher.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> with TickerProviderStateMixin {
  MapController mapController;
  List<Marker> markerList = [];

  @override
  void initState() {
    super.initState();
    markerList.clear();
    mapController = new MapController();
  }

  void sendSms(String number) => launch("sms:$number");

  void openDrawer({ReliefCenterModel modelData}) async {
    await Future.delayed(Duration(milliseconds: 250));
    String availability = '';
    modelData.availability.forEach((day) {
      availability += "${day.substring(0, 3)} ";
    });
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: (context),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Center(
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AutoSizeText(
                          '${modelData.reliefCenterName}',
                          maxFontSize: 20.0,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: mBold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Calamity',
                                    style: TextStyle(
                                      fontFamily: mBold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  Text(
                                    '${modelData.calamityName}',
                                    style: TextStyle(
                                      fontFamily: mMedium,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10.0),
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Contact Person',
                                    style: TextStyle(
                                      fontFamily: mBold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${modelData.hostFname} ${modelData.hostLname}',
                                    style: TextStyle(
                                      fontFamily: mRegular,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Contact Number',
                                    style: TextStyle(
                                      fontFamily: mBold,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    // TODO: launch sms
                                    onTap: () => sendSms(modelData.hostContact),
                                    child: Text(
                                      '${modelData.hostContact}',
                                      style: TextStyle(
                                        fontFamily: mMedium,
                                        fontSize: 12.0,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Accepted goods',
                          style: TextStyle(
                            fontFamily: mBold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemCount: modelData.acceptedGoods.length,
                          itemBuilder: (context, i) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 5.0,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 5.0,
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 10,
                              ),
                              child: Center(
                                child: Text(
                                  '${modelData.acceptedGoods[i]}',
                                  style: TextStyle(
                                    fontFamily: mRegular,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            color: Colors.lightBlue[900],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Text(
                                'More info',
                                style: TextStyle(
                                  fontFamily: mBold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MoreInfoPage(
                                  model: modelData,
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            color: Color(0xff6c63ff),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: Text(
                                'Open in Maps',
                                style: TextStyle(
                                  fontFamily: mBold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            onPressed: () => launchMaps(
                              title: modelData.reliefCenterName,
                              desc: modelData.hostContact,
                              latLng: LatLng(
                                double.parse(modelData.hostLocationLat.trim()),
                                double.parse(modelData.hostLocationLong.trim()),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  launchMaps({LatLng latLng, String title, String desc}) async {
    try {
      final availableMaps = await ml.MapLauncher.installedMaps;
      ml.Coords coords = ml.Coords(latLng.latitude, latLng.longitude);
      if (await ml.MapLauncher.isMapAvailable(ml.MapType.google)) {
        await ml.MapLauncher.launchMap(
          mapType: ml.MapType.google,
          coords: coords,
          title: title,
          description: desc,
        );
      } else if (await ml.MapLauncher.isMapAvailable(ml.MapType.waze)) {
        await ml.MapLauncher.launchMap(
          mapType: ml.MapType.waze,
          coords: coords,
          title: title,
          description: desc,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final _latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    var controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataUtils>(context);

    provider.reliefCenterModelList.forEach((center) {
      double lat = double.parse(center.hostLocationLat);
      double long = double.parse(center.hostLocationLong);
      markerList.add(Marker(
        point: LatLng(lat, long),
        builder: (context) {
          return GestureDetector(
            onTap: () {
              _animatedMapMove(LatLng(lat, long), provider.currentZoom);
              openDrawer(modelData: center);
            },
            child: Icon(
              Icons.location_on,
              color: Colors.redAccent[400],
              size: 30,
            ),
          );
        },
      ));
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              center: provider.myLoc,
              zoom: 11,
              minZoom: 11,
              maxZoom: 15,
              nePanBoundary: LatLng(19.072501, 126.374430),
              swPanBoundary: LatLng(5.101887, 114.723184),
              interactive: true,
              onPositionChanged: (pos, b) {
                provider.setCurrentZoom(pos.zoom);
              },
            ),
            layers: [
              TileLayerOptions(
                maxZoom: 19,
                urlTemplate:
                    'https://tile.jawg.io/sunny/{z}/{x}/{y}.png?api-key=community',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    point: provider.myLoc ?? LatLng(14.589922, 120.980580),
                    builder: (context) {
                      return Icon(
                        Icons.location_on,
                        color: mainColor,
                        size: 30.0,
                      );
                    },
                  ),
                ],
              ),
              MarkerLayerOptions(
                markers: markerList,
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(
                onPressed: () {
                  _animatedMapMove(
                      provider.myLoc ?? LatLng(14.589922, 120.980580), 15);
                },
                backgroundColor: mainColor,
                child: Icon(
                  Icons.my_location,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
