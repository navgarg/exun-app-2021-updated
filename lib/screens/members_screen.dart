import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Member {
  String name;
  String role;
  String? image;

  Member(this.image, {required this.name, required this.role});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      json["image"],
      name: json["name"],
      role: json["role"],
    );
  }
}

class MembersList {
  String year;
  List<Member> members;

  MembersList({required this.year, required this.members});

  factory MembersList.fromJson(Map<String, dynamic> json) {
    return MembersList(
      year: json["year"],
      members: json["members"], //todo: check??
    );
  }
}

class MembersScreen extends StatefulWidget{

  const MembersScreen({Key? key}) : super(key: key);

  @override
  _MembersScreenState createState() => _MembersScreenState();
}


class _MembersScreenState extends State<MembersScreen>{

  List<MembersList> _membersList = [];
  List<Member> _members = [];
  bool _memberLoaded = false;

  Future<void> getMembers() async {
    // await openBox();
    print("members loaded?");
    print(_memberLoaded);
    if (!_memberLoaded) {
      try {
        var uri = generateUrl(getMembersUrl);
        print(uri);
        var value = await get(uri);
        print("value");
        print(value);
        print("value");
        var parsed = json.decode(value.body);
        print(parsed);
        print(parsed.map((e) => Member.fromJson(e)).toList());
        _membersList = List<MembersList>.from(parsed.map((e) => Member.fromJson(e)).toList());
        // var list = parsed.map<MembersList>((json) => MembersList.fromJson(json)).toList();
        // _membersList = List<MembersList>.from(list);
        // if (parsed["statusCode"] == "S10001") {
          print(_membersList);
          // _members = parsed['rows']
          //     .map<Member>((json) => Member.fromJson(json))
          //     .toList();
          // print(_members);
          _memberLoaded = true;
          print(_memberLoaded);
        // }
        setState(() {});
      } catch (e) {
        _members = [];
        print("error");
        print(e);
        print("error");
        _memberLoaded = true;

        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMembers(),
      builder: (ctx, snapshot) =>
      snapshot.connectionState == ConnectionState.waiting
          ? Center(
        child: CircularProgressIndicator(),
      )
          : RefreshIndicator(
        onRefresh: () {
          _memberLoaded = false;
          return getMembers();
        },
        child: ListView.builder(
          itemCount: _members.length,
          itemBuilder: (BuildContext context, int index) {
            Member member = _members[index];
            //todo: update
            return Text("data");
            // return TalksTile(
            //     title: talk.title,
            //     aboutSpeaker: talk.aboutSpeaker,
            //     videoUrl: talk.videoUrl,
            //     aboutTalk: talk.aboutTalk,
            //     speaker: talk.speaker,
            //     image: talk.image
            // );
          },
        ),
      ),
    );  }

}