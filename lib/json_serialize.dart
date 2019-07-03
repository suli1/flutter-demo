import 'dart:convert';

import 'package:demo/entity/book.dart';
import 'package:demo/entity/user.dart';
import 'package:flutter/material.dart';

class JsonWidget extends StatefulWidget {
  static const routeName = '/json';

  @override
  State<StatefulWidget> createState() {
    return JsonSerializingState();
  }
}

class JsonSerializingState extends State<JsonWidget> {
  final String json = '{\"name": \"John Smith\",\"email\": \"john@example.com\"}';
  final String jsonBook =
      '{\"name": \"追风筝的人\",\"author\": \"卡勒德·胡赛尼\",\"cover\": \"https://img3.doubanio.com/view/subject/l/public/s1727290.jpg\"}';

  User user;
  Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JSON serializing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(json),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('Manual Serializing'),
                  onPressed: () {
                    user = User.fromJson(jsonDecode(json));
                    setState(() {});
                  },
                ),
                RaisedButton(
                  child: Text('Automated Serializing'),
                  onPressed: () {
                    book = Book.fromJson(jsonDecode(jsonBook));
                    setState(() {});
                  },
                ),
              ],
            ),
            Text(
              'name: ${user?.name ?? ''}',
              style: primaryText,
            ),
            Text(
              'email: ${user?.email ?? ''}',
              style: primaryText,
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Text(
                'name: ${book?.name ?? ''}',
                style: primaryText,
              ),
            ),
            Text(
              'author:${book?.author ?? ''}',
              style: primaryText,
            ),
            Image.network(book?.cover ?? '', width: 320, height: 320,)
          ],
        ),
      ),
    );
  }
}

const TextStyle primaryText = TextStyle(fontSize: 18, color: Colors.black87);
