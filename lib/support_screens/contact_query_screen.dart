import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constants.dart';

class ContactQueryScreen extends StatefulWidget {
  final String email_to;

  ContactQueryScreen({required this.email_to});

  @override
  _ContactQueryScreenState createState() => _ContactQueryScreenState();
}
class _ContactQueryScreenState extends State<ContactQueryScreen>{

  final _emailToController = TextEditingController();
  final _emailFromController = TextEditingController();
  final _subjectController = TextEditingController();
  final _queryController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  // String displayText = "";

  void firebaseCall(){
      final query = <String, String>{
        "email_to": _emailToController.text,
        "email_from": _emailFromController.text,
        "subject": _subjectController.text,
        "query": _queryController.text
      };
      _firestore.collection("queries").doc().set(query).onError((e, _) => print("Error $e"));
      _emailToController.value = TextEditingValue(text: "");
      _emailFromController.value = TextEditingValue(text: "");
      _queryController.value = TextEditingValue(text: "");
      _subjectController.value = TextEditingValue(text: "");
      // setState( () {
      //   displayText = "Successfully submitted query!";
      // });
      Fluttertoast.showToast(msg: "Successfully submitted query!");
  }

  @override
  Widget build(BuildContext context) {
    _emailToController.value = TextEditingValue(text: widget.email_to);
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
                controller: _emailToController,
                decoration: InputDecoration(
                    labelText: 'To:'
                ),
                onChanged: (email) {
                  _emailToController.value = TextEditingValue(text: email);
                },
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: _emailFromController,
                decoration: InputDecoration(
                    labelText: 'From:'
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(
                    labelText: 'Subject'
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              TextFormField(
                controller: _queryController,
                decoration: InputDecoration(
                    labelText: 'Query'
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
                      if(_subjectController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide subject");
                      } else if(_queryController.text.isEmpty){
                        Fluttertoast.showToast(msg: "Please provide query");
                      }
                      if (EmailValidator.validate(_emailToController.text) &&
                          EmailValidator.validate(_emailFromController.text)){
                        Fluttertoast.showToast(msg: "Invalid email. Please try again");
                      }
                      if (_subjectController.text.isNotEmpty &&
                      _queryController.text.isNotEmpty &&
                      EmailValidator.validate(_emailToController.text) &&
                      EmailValidator.validate(_emailFromController.text)){
                        firebaseCall();
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