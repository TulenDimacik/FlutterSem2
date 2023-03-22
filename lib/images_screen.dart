
import 'dart:typed_data';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Photo extends StatefulWidget {

  late final String title;

  @override
  _PhotoState createState() => _PhotoState();
  static const routeName = '/photo';
}

class _PhotoState extends State<Photo> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();
  int counter = 0;

  void FilePick() async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      dialogTitle: 'Выбор файла',
    );

    if(result != null){
      //final size = result.files.first.size;
      Uint8List? file = result.files.single.bytes;
      //final fileExtensions = result.files.first.extension!;
      //print("размер:$size file:${file.path} fileExtensions:${fileExtensions}");

      //final f = FirebaseStorage.instance.ref().child(getRandomString(5)).putFile(file);
      Reference ref = FirebaseStorage.instance.ref().child('${DateTime.now()}.png');
      UploadTask uploadTask = ref.putData(file!, SettableMetadata(contentType: 'image/png'));
      TaskSnapshot taskSnapshot = await uploadTask
        .whenComplete(() => print('done'))
          .catchError((error) => print('something went wrong'));
      String url = await taskSnapshot.ref.getDownloadURL();
    }
    else{
      
    }
    
  }

  String link = '';
  List<ModelTest> fullpath = [];

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))
  ));

  Future<void> initImage() async {
    fullpath.clear();
    final storageReference = FirebaseStorage.instance.ref().list();
    final list = await storageReference;
    list.items.forEach((element) async {
      final url = await element.getDownloadURL();
      fullpath.add(ModelTest(url, element.name));
      
      setState(() {});

    });
    print(fullpath.length);
    print(list.items.length);
  }

  @override
  void initState(){
    initImage().then((value){

      setState(() {});
      print(fullpath.length);
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text('title'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () async{
            await initImage();
          },
            child: const Text("Обновить")),
        ],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
           children: [
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: fullpath.length,
                itemBuilder: (context, index){
                  return Card(
                    child: InkWell(
                      onLongPress: () async{
                        link = '';
                        await FirebaseStorage.instance.ref("/" + fullpath[index].name!).delete();
                        await initImage();
                        setState(() {});
                      },
                      onTap: () {
                          link = fullpath[index].url!;
                        setState(() {
                        });
                      },
                      child: ListTile(
                        title: Text(fullpath[index].url!),
                      )
         
                    ),
                  );
                }
                ),
            ),
            Expanded(
              flex: 2,
              child: Image.network(
                link,
                errorBuilder: (context, error, stackTrace){
                  return Text('Ошибка');
                },
              ),
            )
           ],
           ) 
        ),
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
  
  ModelTest( this.url, this.name);

}