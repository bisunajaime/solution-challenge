import 'package:flutter/material.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/models/reliefcenter_model.dart';
import 'package:helpinghand/pages/moreinfo_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ReliefCenterListWidget extends StatelessWidget {
  final ReliefCenterModel model;
  ReliefCenterListWidget({this.model});
  @override
  Widget build(BuildContext context) {
    void sendSms(String number) => launch("sms:$number");

    return Container(
      height: 150,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: Colors.redAccent[400],
                    size: 15.0,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${model.reliefCenterName}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.title.copyWith(
                          fontSize: 15.0,
                          fontFamily: mBold,
                        ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                    '${model.availabilityStartTime} - ${model.availabilityEndTime}'),
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.person,
                color: Colors.blue,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              Text('${model.hostLname}, ${model.hostFname}'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.chat,
                color: Colors.blue,
                size: 15,
              ),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () => sendSms(model.hostContact),
                child: Text(
                  '${model.hostContact}',
                  style: TextStyle(
                    color: Colors.indigoAccent,
                    decoration: TextDecoration.underline,
                    fontFamily: mBold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SizedBox(),
          ),
          MaterialButton(
            color: mainColor,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MoreInfoPage(
                  model: model,
                ),
              ),
            ),
            child: Center(
              child: Text(
                'More info',
                style: TextStyle(
                  fontFamily: mBold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
