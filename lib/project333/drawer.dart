import 'package:fin_fin_ses/baseUrl.dart';
import 'package:fin_fin_ses/models/user.dart';
import 'package:fin_fin_ses/project333/routes.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'divider.dart';
import 'navItems.dart';
import 'package:dio/dio.dart';

import 'secureStorageClass.dart';

class Drawerr extends StatelessWidget {
  Drawerr({
    super.key,
  });
  final dio = Dio();

  Future<User> getHttp() async {
    final _storage = SecureStorage();
    dynamic token = await _storage.read('jwt');
    // print(token);
    Response response = await dio.get(
        '$baseUrl/user',
        options: Options(headers: {'auth': token}));
    User user = User.fromJson(response.data);
    print(user.firstName);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: getHttp(),
        builder: (context, snapshot) {
          User? user = snapshot.data;
          return Drawer(
            backgroundColor:UgBlue,
            child: Container(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Center(
                      child: ListTile(
                        title: Text(
                          user != null
                              ? '${user.firstName} ${user.lastName}'
                              : '',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(user != null ? user.studentMail : '',
                            style: const TextStyle(color: Colors.white)),
                        leading: const CircleAvatar(
                          child: Icon(
                            Icons.perm_identity,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  NavItems(
                    text: 'Home',
                    myRoute: NewsPageRoute,
                    myIcon: const Icon(Icons.home),
                  ),
                  const ItemDivider(),
                  NavItems(
                    text: 'My Courses',
                    myRoute: CoursesRoute,
                    myIcon: const Icon(Icons.animation_outlined),
                  ),
                  const ItemDivider(),
                  NavItems(
                    text: 'My Grades',
                    myRoute: GradesRoute,
                    myIcon: const Icon(Icons.newspaper),
                  ),
                  const ItemDivider(),
                  NavItems(
                    text: 'Announcements',
                    myRoute: AnnouncementsRoute,
                    myIcon: const Icon(Icons.add_home_work),
                  ),
                  const ItemDivider(),
                  SizedBox(
                    height: 150,
                  ),
                  NavItems(
                    text: 'Logout',
                    myRoute: LoginPageRoute,
                    myIcon: const Icon(Icons.logout),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
