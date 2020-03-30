import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/pages/home_page.dart';
import 'package:helpinghand/pages/onboarding_page.dart';
import 'package:helpinghand/utils/data_utils.dart';
import 'package:helpinghand/widgets/conditional_widget.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckLocationWidget extends StatelessWidget {
  Stream<PermissionStatus> askLocationPermission() async* {
    Stream<PermissionStatus> permissionStatus =
        LocationPermissions().requestPermissions().asStream();
    yield* permissionStatus;
  }

  Future askPermission() async {
    bool isOpened = await LocationPermissions().openAppSettings();
    print(isOpened);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataUtils>(context);
    return Scaffold(
      body: StreamBuilder<PermissionStatus>(
          stream: askLocationPermission(),
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              if (snapshot.data == PermissionStatus.granted) {
                return ConditionalWidget();
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        height: 150,
                        image: AssetImage(
                          'assets/images/map-permission.png',
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        'If you denied access, to allow location services. \nTap on "Open Settings" and re-launch the application.',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      GestureDetector(
                        onTap: askPermission,
                        child: Text(
                          'Open settings',
                          style: Theme.of(context).textTheme.subtitle.copyWith(
                                color: mainColor,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2.0,
                              ),
                        ),
                      )
                    ],
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
