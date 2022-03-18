import 'package:flutter/foundation.dart';

import '../model/server.dart';
import 'create_post.dart';
import 'package:flutter/material.dart';
import 'edit_post.dart';

// This project by Salar Brefki
//برمجة وتطوير سالار بريفكي
// YouTube: https://www.youtube.com/channel/UCphD-Ww9JnrBXRfzy6Ivg0g
// Facebook: https://www.facebook.com/salar.brefki
//Instagram: https://www.instagram.com/salarbrefki

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List _posts = [];

  @override
  // ignore: must_call_super
  void initState() {
    _getPosts();
  }

  Future<void> _getPosts() async {
    Services.getAllPosts().then((posts) {
      setState(() {
        _posts = posts;
      });
      if (kDebugMode) {
        print('Length: ${_posts.length}');
      }
    });
  }

  _deletePost(String selectPostId) {
    Services.deletePost(selectPostId).then((result) {
      if ('success' == result) {
        _getPosts();
        if (kDebugMode) {
          print('Delete done');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePost()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            _getPosts();
          },
          icon: const Icon(Icons.refresh),
        ),
      ),
      body: _posts.isEmpty
          ? const Center(
        child: Text(
          'لا يوجد اي منشور \nاضغط على + لاضافة منشور',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      )
          : RefreshIndicator(
        onRefresh: _getPosts,
        backgroundColor: Colors.blue,
        color: Colors.white,
        child: ListView.builder(
          itemCount: _posts.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffEBEBEB),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  size: 20,
                                ),
                                color: Colors.red,
                                onPressed: () {
                                  _deletePost(_posts[index].id);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  size: 20,
                                ),
                                color: Colors.blue,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditPost(
                                          postId: _posts[index].id,
                                          username:
                                          _posts[index].username,
                                          postTitle:
                                          _posts[index].postTitle,
                                          postText:
                                          _posts[index].postText,
                                        )),
                                  );
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${_posts[index].username}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue,
                                ),
                              ),
                              const Icon(
                                Icons.person,
                                size: 35,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${_posts[index].postTitle}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SelectableText(
                        '${_posts[index].postText}',
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}