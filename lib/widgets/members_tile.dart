import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../main_screens/members_screen.dart';

class MembersTile extends StatelessWidget{

  final List<Member> membersList;
  final String year;

  const MembersTile({
    Key? key,
    required this.membersList,
    required this.year,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(year,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: KColors.primaryText,
                  )
              ),

              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: membersList.length,
                  itemBuilder: (BuildContext context, int i) {
                    Member member = membersList[i];
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
  }

}