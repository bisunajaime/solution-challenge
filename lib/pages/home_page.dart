import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:helpinghand/models/reliefcenter_model.dart';
import 'package:helpinghand/utils/data_utils.dart';
import 'package:helpinghand/widgets/loading_widget.dart';
import 'package:helpinghand/widgets/stepper_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var reliefCenters =
        FirebaseDatabase.instance.reference().child('reliefcenter');
    final provider = Provider.of<DataUtils>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.subtitle.copyWith(
                fontSize: 20.0,
                color: Colors.white,
              ),
        ),
      ),
      body: StreamBuilder(
          stream: reliefCenters.onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            print(snapshot.connectionState);
            if (snapshot.hasData) {
              switch (snapshot.connectionState) {
                case ConnectionState.active:
                case ConnectionState.done:
                  DataSnapshot snap = snapshot.data.snapshot;
                  var encode = jsonEncode(snap.value);
                  List<ReliefCenterModel> model = [];
                  jsonDecode(encode).forEach((k, v) {
                    model.add(ReliefCenterModel.fromJson(v));
                  });
                  print(model);
                  provider.setReliefCenterModelList(model);
                  return StepperWidget();
                  break;
                case ConnectionState.waiting:
                  return LoadingWidget(
                    loadingMsg: 'Fetching data',
                  );
                  break;
                default:
                  return LoadingWidget(
                    loadingMsg: 'Loading',
                  );
                  break;
              }
            } else {
              return LoadingWidget(
                loadingMsg: 'No Data',
              );
            }
          }),
    );
  }
}
