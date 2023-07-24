import 'dart:convert';
import 'package:fin_fin_ses/project333/secureStorageClass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'constants.dart';
SecureStorage storage = SecureStorage();


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late Map<String, dynamic> decodedData;
  void GetStudentData() async {
  final url = Uri.parse(
      'https://virtually-findings-crowd-medicare.trycloudflare.com/login');
  final headers = {
    'Content-Type': 'application/json',
    'auth': await storage.read('jwt') ?? 'default value if null',
  };
  final response =  await http.get(
    url,
    headers: headers,
  );
  setState((){
final decodedData = jsonDecode(response.body);
  });
  
}

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: Drawerr(),
       // drawer: Drawerr(student_mail: decodedData['first name'], text: decodedData['email'],),
        body: Stack(
          children: [
            IconButton(
              onPressed: () {
                _globalKey.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
            Column(
              children: [
                Text(
                ' MY HOME PAGE',
                style: TextStyle(color: Colors.black),
              ),
              
              
              ],
            ),
          ],
        ),
      ),
    );
  }
}
