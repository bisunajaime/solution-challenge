import 'package:flutter/material.dart';
import 'package:helpinghand/constants/constants.dart';

class LoadingWidget extends StatelessWidget {
  final String loadingMsg;
  LoadingWidget({this.loadingMsg});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text(
              loadingMsg,
              style: TextStyle(
                fontFamily: mBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
