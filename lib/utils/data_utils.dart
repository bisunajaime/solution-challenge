import 'package:flutter/material.dart';
import 'package:helpinghand/models/reliefcenter_model.dart';
import 'package:latlong/latlong.dart';
import 'package:map_launcher/map_launcher.dart' as ml;

class DataUtils extends ChangeNotifier {
  List<ReliefCenterModel> _reliefCenterModelList = [];
  LatLng _myLoc;
  double _currentZoom;

  List<ReliefCenterModel> get reliefCenterModelList => _reliefCenterModelList;
  setReliefCenterModelList(List<ReliefCenterModel> list) {
    _reliefCenterModelList = list;
  }

  LatLng get myLoc => _myLoc;
  setMyLoc({LatLng loc}) {
    _myLoc = loc;
  }

  double get currentZoom => _currentZoom;
  setCurrentZoom(double zoom) {
    _currentZoom = zoom;
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
}
