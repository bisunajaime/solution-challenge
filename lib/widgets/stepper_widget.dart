import 'package:flutter/material.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/main.dart';
import 'package:helpinghand/models/reliefcenter_model.dart';
import 'package:helpinghand/pages/maps_page.dart';
import 'package:helpinghand/pages/moreinfo_page.dart';
import 'package:helpinghand/utils/data_utils.dart';
import 'package:helpinghand/widgets/reliefcenterlist_widget.dart';
import 'package:helpinghand/widgets/stepscontainer_widget.dart';
import 'package:provider/provider.dart';

class StepperWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataUtils>(context);
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/home-bg.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              'Instructions',
              style: TextStyle(
                fontFamily: mBlack,
                fontSize: 25.0,
              ),
            ),
          ),
          Container(
            height: 150,
            width: double.infinity,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                StepsContainerWidget(
                  stepTitle: 'Step 1',
                  stepContent: 'Content',
                ),
                StepsContainerWidget(
                  stepTitle: 'Step 2',
                  stepContent: 'Content',
                ),
                StepsContainerWidget(
                  stepTitle: 'Step 3',
                  stepContent: 'Content',
                ),
                StepsContainerWidget(
                  stepTitle: 'Step 4',
                  stepContent: 'Content',
                ),
                StepsContainerWidget(
                  stepTitle: 'Step 5',
                  stepContent: 'Content',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              'Relief Centers',
              style: TextStyle(
                fontFamily: mBlack,
                fontSize: 25.0,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  ReliefCenterModel model = provider.reliefCenterModelList[i];

                  return ReliefCenterListWidget(
                    model: model,
                  );
                },
                itemCount: provider.reliefCenterModelList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
