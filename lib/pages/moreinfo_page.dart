import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/models/reliefcenter_model.dart';
import 'package:helpinghand/utils/data_utils.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class MoreInfoPage extends StatefulWidget {
  final ReliefCenterModel model;
  MoreInfoPage({this.model});
  @override
  _MoreInfoPageState createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage> {
  MapController mapController;

  LatLng host;
  LatLng delivery;

  _fitBounds() async {
    await Future.delayed(Duration(seconds: 0));
    var bounds = LatLngBounds();
    bounds.extend(host);
    bounds.extend(delivery);
    mapController.fitBounds(
      bounds,
      options: FitBoundsOptions(
        padding: EdgeInsets.all(50),
      ),
    );
  }

  void sendSms(String number) => launch("sms:$number");

  @override
  void initState() {
    mapController = MapController();
    setState(() {
      host = LatLng(double.parse(widget.model.hostLocationLat),
          double.parse(widget.model.hostLocationLong));
      delivery = LatLng(double.parse(widget.model.deliveryLocationLat),
          double.parse(widget.model.deliveryLocationLong));
    });
    _fitBounds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReliefCenterModel model = widget.model;
    final duModel = Provider.of<DataUtils>(context);
    TextStyle label = TextStyle(
      fontFamily: mBlack,
      fontSize: 15.0,
    );
    TextStyle sub = TextStyle(fontFamily: mRegular);
    TextStyle subMed = TextStyle(fontFamily: mMedium);

    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            snap: true,
            expandedHeight: 250,
            title: Text(
              '${widget.model.reliefCenterName}',
              style: TextStyle(
                fontFamily: mBold,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: mainColor,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: Container(
              height: 250,
              width: double.infinity,
              child: FlutterMap(
                key: Key('uniq'),
                mapController: mapController,
                options: MapOptions(
                  interactive: false,
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
                        point: host,
                        builder: (context) {
                          return Icon(
                            Icons.location_on,
                            color: Colors.redAccent[400],
                            size: 30.0,
                          );
                        },
                      ),
                      Marker(
                        point: delivery,
                        builder: (context) {
                          return Icon(
                            Icons.location_on,
                            color: Colors.green,
                            size: 30.0,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              SizedBox(
                height: 10.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Calamity',
                    style: TextStyle(
                      fontFamily: mBold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '${model.calamityName}',
                    style: label.copyWith(
                      fontSize: 30,
                      fontFamily: mBlack,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.redAccent[400],
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Relief Center',
                          style: label,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                      thickness: 1.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AutoSizeText(
                        "${model.reliefCenterName}",
                        textAlign: TextAlign.center,
                        maxFontSize: 13.0,
                        minFontSize: 10.0,
                        maxLines: 3,
                        style: subMed,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Colors.green,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'Destination of Goods',
                          style: label,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black26,
                      thickness: 1.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AutoSizeText(
                        "${model.deliveryTarget}",
                        textAlign: TextAlign.center,
                        maxFontSize: 13.0,
                        minFontSize: 10.0,
                        maxLines: 3,
                        style: subMed,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.contact_phone,
                                color: Color(0xff6C63FF),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Contact',
                                style: label,
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.black26,
                            thickness: 1.0,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                          Text(
                            "${model.hostLname}, ${model.hostFname}",
                            style: sub,
                          ),
                          GestureDetector(
                            onTap: () => sendSms(model.hostContact),
                            child: Text(
                              '${model.hostContact}',
                              style: sub.copyWith(
                                color: mainColor,
                                fontFamily: mMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                          )
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.calendar_today,
                                color: Color(0xff6C63FF),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                'Schedule',
                                style: label,
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.black26,
                            thickness: 1.0,
                            indent: 10.0,
                            endIndent: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    'Start',
                                    style: label,
                                  ),
                                  Text(
                                    DateFormat.yMd().format(
                                        DateTime.parse(model.startDate)),
                                    style: sub,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    'End',
                                    style: label,
                                  ),
                                  Text(
                                    DateFormat.yMd()
                                        .format(DateTime.parse(model.endDate)),
                                    style: sub,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.access_time,
                            color: Color(0xff6C63FF),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Availability',
                            style: label,
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 10.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0,
                                ),
                              ],
                            ),
                            child: Text(
                              '${model.availabilityStartTime} - ${model.availabilityEndTime}',
                              style: subMed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                      thickness: 1.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: model.availability.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Text(
                                '${model.availability[i]}',
                                style: subMed,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 10.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                    )
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.free_breakfast,
                            color: Color(0xff6C63FF),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Accepted Goods',
                            style: label,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                      thickness: 1.0,
                      indent: 10.0,
                      endIndent: 10.0,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: model.acceptedGoods.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                  )
                                ],
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 5.0),
                              child: Text(
                                '${model.acceptedGoods[i].keys.toString().replaceAll('(', '').replaceAll(')', '')}',
                                style: subMed,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: Color(0xff6c63ff),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
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
                  onPressed: () => duModel.launchMaps(
                    title: model.reliefCenterName,
                    desc: model.hostContact,
                    latLng: LatLng(
                      double.parse(model.hostLocationLat.trim()),
                      double.parse(model.hostLocationLong.trim()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
