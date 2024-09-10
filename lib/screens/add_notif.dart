import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class AddNotifScreen extends StatelessWidget {

  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _eventController = TextEditingController();
  final _messageController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  void addNotif () async {

    final query = <String, dynamic>{
      "title": _titleController.text,
      "subtitle": _subtitleController.text,
      "event": _eventController.text,
      "message": _messageController.text,
      "created_at": DateTime.now()
    };
    _firestore.collection("notifications").doc().set(query).onError((e, _) => print("Error $e"));
    _titleController.value = TextEditingValue(text: "");
    _subtitleController.value = TextEditingValue(text: "");
    _eventController.value = TextEditingValue(text: "");
    _messageController.value = TextEditingValue(text: "");
    // setState( () {
    //   displayText = "Successfully submitted query!";
    // });
    Fluttertoast.showToast(msg: "Successfully added notification!");
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
                  controller: _titleController,
                  decoration: InputDecoration(
                      labelText: 'Title'
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  controller: _subtitleController,
                  decoration: InputDecoration(
                      labelText: 'Subtitle:'
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
                  controller: _messageController,
                  decoration: InputDecoration(
                      labelText: 'Message'
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                //todo: add field for submitting files.
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: ()async {
                      if(_titleController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide Title");
                      } else if(_subtitleController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide subtitle");
                      } else if(_eventController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide Event category");
                      } else if(_messageController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide message");
                      }

                      if (_titleController.text.isNotEmpty &&
                          _subtitleController.text.isNotEmpty &&
                          _messageController.text.isNotEmpty &&
                      _eventController.text.isNotEmpty
                      ){
                        addNotif();
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


