import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:userapp/UserModel.dart';
import 'package:userapp/network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserApp(),
      title: 'My Flutter UserList',
    );
  }
}

class UserApp extends StatefulWidget {
  const UserApp({Key? key}) : super(key: key);

  @override
  State<UserApp> createState() => _UserAppState();
}

class _UserAppState extends State<UserApp> {
  List<GetApiList> _getApiLists = List<GetApiList>.from(<GetApiList>[]);
  List<GetApiList> _getApiListsDisplay = List<GetApiList>.from(<GetApiList>[]);
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    fetchGetApiList().then((value) {
      setState(() {
        _isLoading = false;
        _getApiLists.addAll(value);
        _getApiListsDisplay = _getApiLists;
      });
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 238, 234, 234),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 23, 129, 143),
          title: Center(child: Text("User Data")),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            if (!_isLoading) {
              return index == 0 ? _searchBar() : _listItem(index - 1);
            } else
              return Center(child: CircularProgressIndicator());
          },
          itemCount: _getApiListsDisplay.length + 1,
        )

        
        );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'search...',
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _getApiListsDisplay = _getApiLists.where((getApiList) {
              var getApiListTitle = getApiList.username!.toLowerCase();
              return getApiListTitle.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
       color: Color.fromARGB(255, 210, 231, 234) ,
            elevation: 5,
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                child: Text(_getApiListsDisplay[index].username.toString()),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20.0,bottom: 10),
                child: Text(_getApiListsDisplay[index].email.toString()),
              ),
              trailing: Padding(padding: EdgeInsets.only(top:7,right:5),
                child: Text(_getApiListsDisplay[index].name.toString()),
              ),
            ));
  }
}
