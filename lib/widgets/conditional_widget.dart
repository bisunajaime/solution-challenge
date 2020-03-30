import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helpinghand/pages/home_page.dart';
import 'package:helpinghand/pages/onboarding_page.dart';
import 'package:helpinghand/utils/data_utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latlong/latlong.dart';

class ConditionalWidget extends StatefulWidget {
  @override
  _ConditionalWidgetState createState() => _ConditionalWidgetState();
}

class _ConditionalWidgetState extends State<ConditionalWidget> {
  bool show = false;
  LatLng loc;
  Future<void> shouldOnBoardShow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      show = (prefs.getBool('boolValue') ?? true);
    });
  }

  Future getPos() async {
    Position pos = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    setState(() {
      loc = LatLng(pos.latitude, pos.longitude);
    });
    print("MY LOC: $loc");
  }

  @override
  void initState() {
    super.initState();
    getPos();
    shouldOnBoardShow();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataUtils>(context);
    provider.setMyLoc(loc: loc ?? LatLng(14.589922, 120.980580));
    return show ? OnBoardingPage() : HomePage();
  }
}
