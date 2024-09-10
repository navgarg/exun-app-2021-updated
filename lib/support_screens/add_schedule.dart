import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/main_screens/schedule_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class AddScheduleScreen extends StatelessWidget {

  final _nameController = TextEditingController();
  final _infoController = TextEditingController();
  final _eventController = TextEditingController();
  final _dateController = TextEditingController(); //todo: date picker?
  final _firestore = FirebaseFirestore.instance;

  void addSchedule () async {

    Schedule schedule = new Schedule(_nameController.text, _infoController.text, _eventController.text, date: DateTime.now());
    // _firestore.collection("notifications").doc().set(query).onError((e, _) => print("Error $e"));
    // _nameController.value = TextEditingValue(text: "");
    // _infoController.value = TextEditingValue(text: "");
    // _eventController.value = TextEditingValue(text: "");
    // _dateController.value = TextEditingValue(text: "");
    // setState( () {
    //   displayText = "Successfully submitted query!";
    // });
    Fluttertoast.showToast(msg: "Successfully added schedule!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      labelText: 'Name'
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _infoController,
                  decoration: InputDecoration(
                      labelText: 'Information:'
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _eventController,
                  decoration: InputDecoration(
                      labelText: 'Event Category'
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                      labelText: 'Date'
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: ()async {
                      if(_nameController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide Name");
                      } else if(_infoController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide information");
                      } else if(_eventController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide Event category");
                      } else if(_dateController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide date");
                      }

                      if (_nameController.text.isNotEmpty &&
                          _infoController.text.isNotEmpty &&
                          _dateController.text.isNotEmpty &&
                          _eventController.text.isNotEmpty
                      ){
                        addSchedule();
                      }

                    },
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: KColors.primaryText,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
                // SizedBox(
                //   height: 50.0,
                // ),
                // Text(
                //   displayText,
                //   style: TextStyle(
                //     fontSize: 13,
                //     color: KColors.primaryText,
                //   ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


