import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants.dart';
import '../widgets/members_tile.dart';
import 'members_screen.dart';

class AlumniScreen extends StatefulWidget{

  const AlumniScreen({Key? key}) : super(key: key);

  @override
  _AlumniScreenState createState() => _AlumniScreenState();
}


class _AlumniScreenState extends State<AlumniScreen> {

  List<MembersList> _alumsList = [];
  bool _alumLoaded = false;

  Future<void> getAlums() async {
    // await openBox();
    print("alums loaded?");
    print(_alumLoaded);
    if (!_alumLoaded) {
      try {
        var uri = generateUrl(getAlumsUrl); //todo: change
        print(uri);
        var value = await get(uri);
        print("value");
        print(value);
        print("value");
        var parsed = json.decode(value.body);
        print(parsed);
        // print(parsed.map((e) => MembersList.fromJson(e)).toList());
        _alumsList = List<MembersList>.from(
            parsed.map((e) => MembersList.fromJson(e)).toList());
        print(_alumsList);
        _alumLoaded = true;
        print(_alumLoaded);
        setState(() {});
      } catch (e) {
        print("error");
        print(e);
        print("error");
        _alumLoaded = true;

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
            _alumLoaded = false;
            return getAlums();
          },
          child: ListView.builder(
              itemCount: _alumsList.length,
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                MembersList alumsList = _alumsList[index];
                return MembersTile(
                    membersList: alumsList.members, year: alumsList.year);
              }
          ),
        )
    );
  }
}
