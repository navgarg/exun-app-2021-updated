import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exun_app_21/constants.dart';
import 'package:flutter/material.dart';

class Member {
  String name;
  String designation;

  Member({required this.name, required this.designation});

  factory Member.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Member(
      name: data["name"],
      designation: data["designation"]
    );
  }
  // Map<String, dynamic> toJson() => {
  //   'name': name,
  //   'designation': designation
  // };
}

class MembersScreen extends StatefulWidget{

  const MembersScreen({Key? key}) : super(key: key);

  @override
  _MembersScreenState createState() => _MembersScreenState();
}


class _MembersScreenState extends State<MembersScreen>{

  final _firestore = FirebaseFirestore.instance;

  Future<List<Member>> getMembers () async {
    print("in getMembers");
    //todo: update wrt new collection.
    final snapshot = await _firestore.collection(membersCollectionRef).get();
    final membersList = snapshot.docs.map((e) => Member.fromSnapshot(e)).toList();
    print(membersList);
    return membersList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Member>>(
          future: getMembers(),
          builder: (context, snapshot){
            if (snapshot.connectionState == ConnectionState.done){
              if (snapshot.hasData) {
                print(snapshot);
                List<Member> membersList = snapshot.data as List<Member>;
                print("membersList");
                print(membersList);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(membersList[index].name),
                                ListView.builder(
                                    itemCount: 2,
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      return Text(membersList[index].designation);
                                    }),
                              ],
                            );
                          }),
                    )
                  ],
                );
              } else if (snapshot.hasError){
                return Center(child: Text(snapshot.error.toString()),);
              } else {
                return Center(child: Text("something went wrong!"),);
              }
            }
            else{
              return const Center(child: CircularProgressIndicator(),);
            }
          })
          // child:
    );
  }

}