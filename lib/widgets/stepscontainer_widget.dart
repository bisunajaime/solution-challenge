import 'package:flutter/material.dart';
import 'package:helpinghand/constants/constants.dart';

class StepsContainerWidget extends StatelessWidget {
  final String stepTitle;
  final String stepContent;

  StepsContainerWidget({this.stepTitle, this.stepContent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 250,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            stepTitle,
            style: Theme.of(context).textTheme.title.copyWith(
                  fontSize: 20,
                  fontFamily: mBold,
                ),
          ),
          Text(
            stepContent,
            style: Theme.of(context).textTheme.body1.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
