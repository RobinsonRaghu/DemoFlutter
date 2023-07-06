import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:friends_list/add_list.dart';
import 'package:friends_list/utils/rest.dart';

import 'models/friend_list.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  State<FriendList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {

  List<FrindListVo> friends = [];

  @override
  void initState() {
    super.initState();
    getFriendList();
  }

  getFriendList() async {
    var value = await ListApi.getFriendList();
    String val = value.body;
    List vals = jsonDecode(val);
    List<FrindListVo> list = [];
    for(var element in vals) {
      FrindListVo frnd = FrindListVo.fromJson(element);
      list.add(frnd);
    }
    setState(() {
      friends = list;
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      floatingActionButton:Padding(
        padding: const EdgeInsets.only(left: 245, top: 20),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddList()))
                .then((value) {
                  getFriendList();
            });
          },
          child: Icon(Icons.add_circle_outlined,
            color: Colors.blue,
            size: 50,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        centerTitle: true,
        title: Text('Friends List',style: TextStyle(
          color: Colors.grey[900]
        ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          await getFriendList();
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Column(
                    children: [
                      for(FrindListVo _vo in friends)
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.blue[50]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: MemoryImage(base64Decode(_vo.photo?.split(',')[1] ?? '')),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15,top: 5,),
                                    child: Text(_vo.name ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),),
                                  ),
                                  SizedBox(height: 2,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15, bottom: 5),
                                    child: Text(_vo.area ?? '',
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                      fontSize: 13,
                                    ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }


}
