import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants.dart';
import '../widgets/members_tile.dart';
import 'members_screen.dart';

class FacultyScreen extends StatefulWidget{

  const FacultyScreen({Key? key}) : super(key: key);

  @override
  _FacultyScreenState createState() => _FacultyScreenState();
}


class _FacultyScreenState extends State<FacultyScreen> {

  List<MembersList> _facultyList = [];
  bool _facultyLoaded = false;

  Future<void> getAlums() async {
    // await openBox();
    print("faculty loaded?");
    print(_facultyLoaded);
    if (!_facultyLoaded) {
      try {
        var uri = generateUrl(getFacultyUrl); //todo: change
        print(uri);
        var value = await get(uri);
        print("value");
        print(value);
        print("value");
        var parsed = json.decode(value.body);
        print(parsed);
        // print(parsed.map((e) => MembersList.fromJson(e)).toList());
        _facultyList = List<MembersList>.from(
            parsed.map((e) => MembersList.fromJson(e)).toList());
        print(_facultyList);
        _facultyLoaded = true;
        print(_facultyLoaded);
        setState(() {});
      } catch (e) {
        print("error");
        print(e);
        print("error");
        _facultyLoaded = true;

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAlums(),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : RefreshIndicator(
          onRefresh: () {
            _facultyLoaded = false;
            return getAlums();
          },
          child: ListView.builder(
              itemCount: _facultyList.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                MembersList facultyList = _facultyList[index];
                return MembersTile(
                    membersList: facultyList.members, year: facultyList.year);
              }
          ),
        )
    );
  }
}
