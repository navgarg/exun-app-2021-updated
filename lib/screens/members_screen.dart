import 'dart:convert';
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
      json["image"] ?? "/assets/circuit.png",
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
    print("in constr.");
      // if (json['year'] is! String) {
      //   throw FormatException('Invalid JSON: required "year" field of type String in $json');
      // }
      // if (json['members'] is! List<Member>) {
      //   throw FormatException('Invalid JSON: required "members" field of type list in $json');
      // }
    print(json["members"]);
    final membersData = json["members"] as List<dynamic>;
    return MembersList(
      year: json["year"],
      members: membersData.map((e) => Member.fromJson(e as Map<String, dynamic>)).toList(),
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
        print(parsed[0]["year"]);
        print(parsed[0]["members"]);
        print("members");
        // print(parsed.map((e) => MembersList.fromJson(e)).toList());
        _membersList = List<MembersList>.from(parsed.map((e) => MembersList.fromJson(e)).toList());
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
          itemCount: _membersList.length,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            MembersList membersList = _membersList[index];
            //todo: explore listview.separated for year
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(membersList.year,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: KColors.primaryText,
                  )
                  ),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                      itemCount: membersList.members.length,
                      itemBuilder: (BuildContext context, int i) {
                        Member member = membersList.members[i];
                        var icon = "circuit";
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            leading: Image.asset('assets/$icon.png'),
                            title: Text(member.name,
                              style: const TextStyle(
                                fontSize: 16,
                                color: KColors.primaryText,
                              ),),
                            subtitle: Text(
                              member.role,
                              style: const TextStyle(
                                color: KColors.bodyText,
                                fontSize: 13.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: KColors.border, width: 1),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      })
                ],
              ),
            );
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