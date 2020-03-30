import 'package:flutter/material.dart';
import 'package:helpinghand/constants/constants.dart';
import 'package:helpinghand/pages/maps_page.dart';
import 'package:helpinghand/utils/data_utils.dart';
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
      child: ListView(
        children: <Widget>[
          Stepper(
            physics: BouncingScrollPhysics(),
            currentStep: 0,
            steps: [
              Step(
                title: Text(
                  'Step 1',
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text('Instructions'),
                content: Text('The Content'),
                isActive: true,
              ),
              Step(
                title: Text(
                  'Step 2',
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text('Instructions'),
                content: Text('The Content'),
                isActive: true,
              ),
              Step(
                title: Text(
                  'Step 3',
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text('Instructions'),
                content: Text('The Content'),
                isActive: true,
              ),
              Step(
                title: Text(
                  'Step 4',
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text('Instructions'),
                content: Text('The Content'),
                isActive: true,
              ),
              Step(
                title: Text(
                  'Step 5',
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text('Instructions'),
                content: Text('The Content'),
                isActive: true,
              ),
              Step(
                title: Text(
                  'Step 6',
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text('Instructions'),
                content: Text('The Content'),
                isActive: true,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              color: Color(0xff6c63ff),
              child: Text(
                'Find Centers',
                style: TextStyle(
                  fontFamily: mBold,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapsPage(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
