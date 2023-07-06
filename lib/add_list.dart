import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:friends_list/models/add_friend.dart';
import 'package:friends_list/utils/rest.dart';
import 'package:image_picker/image_picker.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController placeCtrl = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  String photo = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        centerTitle: true,
        title: Text('Form',
        ),
      ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: nameCtrl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Friend name',
            ),
          ),
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: placeCtrl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Friend Place',
            ),
          ),
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: dobCtrl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Friend DOB',
            ),
          ),
        ),
        SizedBox(height: 5,),
        InkWell(
          onTap: () async {
            ImagePicker _picker = ImagePicker();
            XFile? image = await _picker.pickImage(source: ImageSource.gallery);
            if(image == null) return;
            String fileName = image.name;
            List<String> filesplit = fileName.split('.');
            String extension = filesplit[filesplit.length -1];
            Uint8List fileBytes = await image.readAsBytes();
            String fileString = base64Encode(fileBytes);
            fileString = 'data:image/$extension;base64,$fileString';
            print(fileString);
            photo = fileString;

          },
          child: Row(
            children: [
              Image.network(
                  'https://www.shutterstock.com/image-vector/upload-icon-flat-vector-download-260nw-1378175036.jpg',
                height: 80,
                width: 80,
              ),
              Expanded(child: Text('Upload the photo'))
            ],
          ),
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                AddFriendVo _vo = AddFriendVo();
                _vo.name = nameCtrl.text;
                _vo.area = placeCtrl.text;
                _vo.dob = dobCtrl.text;
                _vo.photo = photo;
                ListApi.post('', body: _vo.toJson()).then((value) {
                  print(value);
                  Navigator.pop(context);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Text('SUBMIT', style: TextStyle(color: Colors.white),),
              ),
            )
          ],
        )

      ],
    ),
    );
  }
}
