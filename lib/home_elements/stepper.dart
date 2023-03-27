import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:well_being_app/screens/journal/gratitude.dart';
import 'package:well_being_app/screens/journal/note.dart';

class StepperWidget extends StatefulWidget {
  const StepperWidget({Key key}) : super(key: key);

  @override
  _StepperWidgetState createState() => _StepperWidgetState();
}

class _StepperWidgetState extends State<StepperWidget> {
  //GoogleSignIn _googleSignIn = new GoogleSignIn(scopes: ['email']);
  //the components of stepper called steps
  List<Step> steps = [
    Step(
      title: Text("Plan my day"),
      isActive: true,
      state: StepState.complete,
      content: Text(""),
    ),
    Step(
      isActive: true,
      state: StepState.complete,
      title: Text("Meditate"),
      content: Text(""),
    ),
    Step(
      state: StepState.complete,
      title: Text("Night Routine"),
      content: Text(""),
    ),
  ];
  //functions for continue and on tapping
  int currentStep = 0;
  bool complete = false;
  next() {
    currentStep + 1 != steps.length
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  goTo(int step) {
    setState(() {
      currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(5.0, 20.0, 15.0, 3.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    radius: 40,
                    child: Image.network('https://image.similarpng.com/very-thumbnail/2022/02/Marine-animal-kawaii-character-baby-fairytale-unicorn-on-transparent-background-PNG.png'),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Hey! Good Morning",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w600,color: Colors.white),),
                        Text("Andy",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.w800))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stepper(
            //for changing the continue and cancel button design
            controlsBuilder: (BuildContext context, ControlsDetails dtl) {
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: dtl.onStepCancel,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          (currentStep == 1) ? "Take Me There" : "Let's Do It"),
                    ),
                    // style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all<Color>(Colors.black),
                    // ),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: dtl.onStepContinue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Done"),
                    ),
                    // style: ButtonStyle(
                    //     backgroundColor:
                    //         MaterialStateProperty.all<Color>(Colors.amber)),
                  )
                ],
              );
            },
            //declaring other properties
            steps: steps,
            currentStep: currentStep,
            onStepContinue: next,
            onStepTapped: (step) => goTo(step),
            onStepCancel: () => {
              debugPrint("Pressed"),
              if (currentStep == 0)
                {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Note();
                  }))
                }
              else if (currentStep == 1)
                {
                  //Navigator.pushNamed(context, 'MeditationScreen'),
                }
              else if (currentStep == 2)
                {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return Gratitude();
                  }))
                }
            },
          )
        ],
      ),
    );
  }
}
