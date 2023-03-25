import 'dart:typed_data';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Photo extends StatefulWidget {
  late final String title;

  @override
  _PhotoState createState() => _PhotoState();
  static const routeName = '/main/photo';
}

final auth = FirebaseAuth.instance;

class _PhotoState extends State<Photo> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();
  int counter = 0;

  void FilePick() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: 'Выбор файла',
    );

    if (result != null) {

      Uint8List? file = result.files.single.bytes;
      String name = getRandomString(5);
      Reference ref = FirebaseStorage.instance.ref().child('${name}.png');
      UploadTask uploadTask = ref.putData(file!,
          SettableMetadata(customMetadata: {"User": auth.currentUser!.uid}));

      final FirebaseFirestore fireStore = FirebaseFirestore.instance;

      await fireStore
          .collection('images')
          .doc(name)
          .set(
            {
              'size': size1,
              'path': file.toString(),
              'name': name,
            },
          )
          .then((value) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("images info Added"))))
          .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to add images info: $error"))));
    } else {}
  }

  String link = '';
  String name1 = '';
  int? size1 = 0;

  // String url1='';
  List<ModelTest> fullpath = [];

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> initImage() async {
    fullpath.clear();
    final stor = FirebaseStorage.instance.ref().list();
    final list = await stor;
    list.items.forEach((element) async {
      final meta = await element.getMetadata();
      final customValue = meta.customMetadata!['User'];
      final url = await element.getDownloadURL();
      size1 = meta.size;
      if (customValue == auth.currentUser!.uid) {
        
        // Uint8List? size = await element.getData();
        //    size1=size.toString();
        fullpath.add(ModelTest(url, element.name, size1));
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    initImage().then((value) {
      setState(() {});
      print(fullpath.length);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () async {
                await initImage();
              },
              child: const Text("Обновить")),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount: fullpath.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                        onLongPress: () async {
                          link = '';
                          await FirebaseStorage.instance
                              .ref("/" + fullpath[index].name!)
                              .delete();
                          await initImage();
                          setState(() {});
                        },
                        onTap: () {
                          link = fullpath[index].url!;
                          setState(() {});
                        },
                        child: ListTile(
                          title: Text(fullpath[index].url! +
                              ' ' +
                              fullpath[index].name! +
                              ' ' +
                              size1!.toString()),
                        )
                        /*Image.network(
        fullpath[index].url!,
        width: 200,
        height: 200,
        //fit: BoxFit.cover,
      ),*/
                        ),
                  );
                }),
          ),
          Expanded(
            flex: 2,
            child: Image.network(
              link,
              errorBuilder: (context, error, stackTrace) {
                return Text('Ошибка');
              },
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: FilePick,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ModelTest {
  String? url;
  String? name;
  int? size;

  ModelTest(this.url, this.name, this.size);
}
