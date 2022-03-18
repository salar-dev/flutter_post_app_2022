import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/server.dart';

// This project by Salar Brefki
//برمجة وتطوير سالار بريفكي
// YouTube: https://www.youtube.com/channel/UCphD-Ww9JnrBXRfzy6Ivg0g
// Facebook: https://www.facebook.com/salar.brefki
//Instagram: https://www.instagram.com/salarbrefki

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final TextEditingController _userNameTD = TextEditingController();
  final TextEditingController _postTitleTD = TextEditingController();
  final TextEditingController _postTextTD = TextEditingController();

  _clearTextInput() {
    _userNameTD.text = '';
    _postTitleTD.text = '';
    _postTextTD.text = '';
  }

  _createTable() {
    Services.createTable().then((result) {
      if ('success' == result) {
        if (kDebugMode) {
          print('success to create table');
        }
      } else {
        if (kDebugMode) {
          print('failed to create table');
        }
      }
    });
  }

  _addPost() {
    _createTable();
    if (_userNameTD.text.isEmpty ||
        _postTitleTD.text.isEmpty ||
        _postTextTD.text.isEmpty) {
      if (kDebugMode) {
        print('Empty Field');
      }
      return;
    } else {
      Services.addPost(
        _userNameTD.text,
        _postTitleTD.text,
        _postTextTD.text,
      ).then((result) {
        if ('success' == result) {
          _clearTextInput();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.blue,
              content: Row(
                children: const [
                  Icon(Icons.thumb_up, color: Colors.white),
                  Text(
                    'تم اضافة المنشور',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أنشاء منشور'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'انشاء منشور',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _userNameTD,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'اسم المستخدم',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _postTitleTD,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'العنوان',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _postTextTD,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'النص',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _addPost();
                    },
                    child: const Text(
                      'نشر الأن',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}