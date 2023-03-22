import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutterr/custom_button.dart';
import 'package:fireflutterr/images_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
  static const routeName = '/main';
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();
  String name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: <Widget>[
          CustomButton(
            content: 'Добавить',
              onPressed: () {
                setState(() {
                  showAddScreen();
                });
              },
             
      )],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('OSHIBKA');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Загрузка");
                }

                return ListView(
                  padding: const EdgeInsets.all(8),
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                onPressed: () async {
                                  deleteUser(document.id);
                                },
                                icon: Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    showUpdateScreen(
                                        data['email'], data['login'], document.id);
                                  });
                                },
                                icon: Icon(Icons.edit),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Почта: " +
                                      data['email'] +
                                      " Логин: " +
                                      data['login'])),
                            ]
                            );
                      })
                      .toList()
                      .cast(),
                );
              },
              
            ),
            
          ),
          Row(
            children: [
              CustomButton(
                content: 'Добавить',
                  onPressed: () {
                    setState(() {
                      showAddScreen();
                    });
                  }),
                  SizedBox(width: 20,),
                  CustomButton(
                content: 'Картинки',
                  onPressed: () {
                    Navigator.pushNamed(context, Photo.routeName);
                  }),
            ],
          ),
        ],
      ),
      
    );
  }

  void showUpdateScreen(String email, String login, String uid) async {
    _emailController.text = email;
    _loginController.text = login;
    showDialog(
      context: context,
      builder: (context) => gradeDialog(1, uid),
    );
  }

  void showAddScreen() async {
    _emailController.text = '';
    _loginController.text = '';
    showDialog(
      context: context,
      builder: (context) => gradeDialog(-1, ''),
    );
  }

  StatefulBuilder gradeDialog(int index, String uid) {
    return StatefulBuilder(
      builder: (context, _setter) {
        if (index == -1) {
          name = 'Добавить';
        } else
          name = 'Изменить';
        return SimpleDialog(
          children: [
            const Spacer(),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26),
            ),
            const Spacer(),
            TextFormField(
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле email пустое';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _loginController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Поле логин пустое';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Логин',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
                content: 'ОК',
                onPressed: () {
                  if (index != -1) {
                    updUser(uid);
                  } else {
                    addUser();
                  }
                }),
          ],
        );
      },
    );
  }

  void addUser() async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    await fireStore
        .collection('user')
        .add(
          {'email': _emailController.text, 'login': _loginController.text},
        )
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Добавился"))))
        .catchError((error) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Не добавился: $error"))));
    Navigator.pop(context);
  }

  void updUser(String uid) async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;
    await fireStore
        .collection('user')
        .doc(uid)
        .set(
          {'email': _emailController.text, 'login': _loginController.text},
        )
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Изменен"))))
        .catchError((error) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Не изменен: $error"))));
    Navigator.pop(context);
  }

  void deleteUser(String uid) async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    await fireStore
        .collection('user')
        .doc(uid)
        .delete()
        .then((value) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Удален"))))
        .catchError((error) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Не удален: $error"))));
  }
}
