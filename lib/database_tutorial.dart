import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return "{ id: $id, name: $name, age: $age}";
  }
}

class DbLog {
  final String operator;
  final dynamic object;

  DbLog({this.operator, this.object});

  @override
  String toString() {
    return '[$operator] ${object.toString()}';
  }
}

const TABLE_DOGS = 'dogs';

Future<Database> database() async {
  return openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE IF NOT EXISTS $TABLE_DOGS (id INTEGER PRIMARY KEY, name TEXT, age INTEGER)");
    },
    version: 1,
  );
}

class DatabaseWidget extends StatelessWidget {
  static const routeName = '/database';

  final Future<Database> database;

  DatabaseWidget({this.database});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
      ),
      body: Center(
        child: FutureBuilder<List<DbLog>>(
          future: database.then((database) => dogs()).then((list) {
            List<DbLog> logs = List();
            logs.addAll(list.map<DbLog>((Dog dog) {
              return DbLog(
                operator: 'QUERY',
                object: dog,
              );
            }).toList());
            return logs;
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _DbTestingWidget(
                database: database,
                logs: snapshot.data,
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<List<Dog>> dogs() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_DOGS);

    return List.generate(maps.length, (i) {
      return Dog(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age'],
      );
    });
  }
}

class _DbTestingWidget extends StatefulWidget {
  final Future<Database> database;
  final List<DbLog> logs;

  _DbTestingWidget({this.database, this.logs});

  @override
  State<StatefulWidget> createState() {
    return _DbTestingState(logs);
  }
}

class _DbTestingState extends State<_DbTestingWidget> {
  final List<DbLog> logs;
  int generateIds = 1;

  _DbTestingState(this.logs);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('insert'),
              onPressed: () async {
                DbLog log = await insertDog(Dog(
                  id: generateIds++,
                  name: 'dog_$generateIds',
                  age: Random().nextInt(30) + 1,
                ));
                setState(() => logs.add(log));
              },
            ),
            RaisedButton(
              child: Text('update'),
              onPressed: () async {
                DbLog log = await updateDog(Dog(
                  id: 2,
                  name: 'Jack',
                  age: 24,
                ));
                setState(() => logs.add(log));
              },
            ),
            RaisedButton(
              child: Text('delete'),
              onPressed: () async {
                DbLog log = await deleteDog(generateIds--);
                setState(() => logs.add(log));
              },
            ),
          ],
        ),
        _DbLogWidget(logs: logs),
      ],
    );
  }

  Future<DbLog> insertDog(Dog dog) async {
    final Database db = await widget.database;
    await db.insert(
      TABLE_DOGS,
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return DbLog(operator: 'INSERT', object: dog);
  }

  Future<DbLog> updateDog(Dog dog) async {
    final Database db = await widget.database;
    await db.update(
      TABLE_DOGS,
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id],
    );
    return Future.value(DbLog(operator: 'UPDATE', object: dog));
  }

  Future<DbLog> deleteDog(int id) async {
    final Database db = await widget.database;

    List<Map<String, dynamic>> results = await db.query(
      TABLE_DOGS,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.length == 1) {
      await db.delete(
        TABLE_DOGS,
        where: 'id = ?',
        whereArgs: [id],
      );
      return DbLog(
          operator: 'DELETE',
          object: Dog(
            id: results[0]['id'],
            name: results[0]['name'],
            age: results[0]['age'],
          ));
    }
    return Future.error('Not found $id');
  }
}

class _DbLogWidget extends StatelessWidget {
  final List<DbLog> logs;

  _DbLogWidget({this.logs});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      children: logs.map<Widget>((DbLog log) {
        Color textColor;
        switch (log.operator) {
          case 'INSERT':
            textColor = Colors.green.shade300;
            break;
          case 'UPDATE':
            textColor = Colors.green.shade800;
            break;
          case 'DELETE':
            textColor = Colors.red;
            break;
          default:
            textColor = Colors.black87;
            break;
        }

        return Text(
          log.toString(),
          style: TextStyle(
            fontSize: 16,
            color: textColor,
          ),
        );
      }).toList(),
    );
  }
}
