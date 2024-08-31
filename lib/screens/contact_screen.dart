import 'dart:convert';
import 'package:exun_app_21/constants.dart';
import 'package:exun_app_21/widgets/members_tile.dart';
import 'package:exun_app_21/widgets/notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Contact {
  String name;
  String role;
  String? number;
  String email;

  Contact(this.number, {required this.name, required this.role, required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      json["number"],
      name: json["name"],
      role: json["role"],
      email: json["email"],
    );
  }
}

class ContactsScreen extends StatefulWidget{

  const ContactsScreen({Key? key}) : super(key: key);

  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}


class _ContactsScreenState extends State<ContactsScreen>{

  List<Contact> _contactsList = [];
  bool _contactLoaded = false;

  Future<void> getContacts() async {
    // await openBox();
    print("contact loaded?");
    print(_contactLoaded);
    if (!_contactLoaded) {
      try {
        var uri = generateUrl(getContactsUrl);
        print(uri);
        var value = await get(uri);
        print("value");
        print(value);
        print("value");
        var parsed = json.decode(value.body);
        print(parsed);
        _contactsList = List<Contact>.from(parsed.map((e) => Contact.fromJson(e)).toList());
        print(_contactsList);
        _contactLoaded = true;
        print(_contactLoaded);
        // }
        setState(() {});
      } catch (e) {
        print("error");
        print(e);
        print("error");
        _contactLoaded = true;

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getContacts(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: () {
            _contactLoaded = false;
            return getContacts();
          },
          child: Padding(padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
          child: ListView.builder(
              itemCount: _contactsList.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                Contact contact = _contactsList[index];
                final role = contact.role;
                final email = contact.email;
                return Padding(padding: EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () async {
                    //todo: update
                    return showDialog(
                        context: context,
                        builder: (BuildContext context ){
                          return NotificationDialog(
                              heading: contact.name,
                              subtitle: contact.role,
                              content: contact.email
                          );
                        });
                  },
                  child: ListTile(
                    title: Text(
                        contact.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: KColors.primaryText,
                        )),
                    subtitle: Text(
                      "$role \n$email",
                      style: const TextStyle(
                        color: KColors.bodyText,
                        fontSize: 13.0,),
                    ),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: KColors.border, width: 1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    isThreeLine: true,

                  ),
                )
                );
              }
             ),
          )
        )
    );
  }

}