import 'dart:convert';
import 'package:fin_fin_ses/project333/routes.dart';
import 'package:fin_fin_ses/project333/secureStorageClass.dart';
import 'package:fin_fin_ses/project333/showErrorDialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../baseUrl.dart';
import 'constants.dart';
import 'header_widget.dart';

SecureStorage _storage = SecureStorage();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  late final TextEditingController _id;
  late final TextEditingController _password;
  @override
  void initState() {
    _id = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _id.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: _headerHeight,
            child: HeaderWidget(
              _headerHeight,
              15,
              '',
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: _id,
                        enableSuggestions: false,
                        autocorrect: false,

                        style:
                            const TextStyle(fontSize: 22, color: Colors.white),
                        textInputAction:
                            TextInputAction.next, //adds next btn to keyboard
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => _id.clear(),
                            icon: Icon(
                              Icons.clear,
                              color: UgYellow,
                            ),
                          ),
                          border: InputBorder
                              .none, //removes that line under the input field
                          hintText: 'Enter your Student Id',

                          prefixIcon: Icon(
                            FontAwesomeIcons.solidEnvelope,
                            color: UgYellow,
                            size: 15,
                          ),
                          hintStyle: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.7), //color and opacity of box
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                      textInputAction:
                          TextInputAction.done, //adds next btn to keyboard
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () => _password.clear(),
                          icon: Icon(
                            Icons.clear,
                            color: UgYellow,
                          ),
                        ),
                        border: InputBorder
                            .none, //removes that line under the input field
                        hintText: 'Enter your password',
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          color: UgYellow,
                          size: 15,
                        ),
                        hintStyle:
                            const TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      obscureText: true,
                      controller: _password,
                      enableSuggestions: false,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Container(
                width: 130,
                decoration: BoxDecoration(
                  color: UgBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: TextButton(
                  onPressed: () async {
                    final id = int.parse(_id.text);
                    final password = int.parse(_password.text);
                    final url = Uri.parse('$baseUrl/login');
                    final headers = {'Content-Type': 'application/json'};
                    final body = jsonEncode({'id': id, 'pin': password});
                    final response =
                        await http.post(url, headers: headers, body: body);

                    late final decodedData;
                    decodedData = jsonDecode(response.body);
                    if (decodedData['token'] == null) {
                      await showErrorDialog(context, decodedData['error']);
                    } else {
                      //Get.to(()=> const News(), transition:Transition.fade);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          NewsPageRoute, (route) => false);

                      await _storage.write('jwt', decodedData['token']);
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Text(
                    'Trouble logging in? Contact our support offices for help',
                    style: TextStyle(color: UgBlue),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
