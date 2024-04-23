import 'package:android/components/drawer_widget.dart';
import 'package:android/components/list_tile.dart';
import 'package:android/components/post_button.dart';
import 'package:android/components/textfield_widget.dart';
import 'package:android/database/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // firestore access
  final FirestoreDatabase database = FirestoreDatabase();

  // controller
  final TextEditingController newPostController = TextEditingController();

  // post message
  void postMessage() {
    // only post when data is there
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("A N D R O I D"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: const DrawerWidget(),
      body: CustomScrollView(
        slivers: [
          // Textfield and Post Button
          SliverPadding(
            padding: const EdgeInsets.all(25.0),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      obscureText: false,
                      controller: newPostController,
                      hinText: 'Write something',
                    ),
                  ),
                  const SizedBox(width: 10),
                  PostButton(onTap: postMessage),
                ],
              ),
            ),
          ),

          // StreamBuilder for Posts
          StreamBuilder(
            stream: database.getPostsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final posts = snapshot.data!.docs;

              if (snapshot.data == null || posts.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No posts, ...write something!"),
                    ),
                  ),
                );
              }

              // List of Posts using SliverList
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final post = posts[index];
                    String message = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];
                    return MyListTile(title: message, subTitle: userEmail);
                  },
                  childCount: posts.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
