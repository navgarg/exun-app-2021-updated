import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MembersScreen extends StatefulWidget{

  const MembersScreen({Key? key}) : super(key: key);

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen>{

  final fruits = List.generate(100, (index) => "Fruit $index");
  final veg = List.generate(100, (index) => "Veg $index");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Parent'),
                      ListView.builder(
                          itemCount: 2,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Text('Child');
                          }),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

}