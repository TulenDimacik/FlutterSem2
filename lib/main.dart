import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fireflutterr/images_screen.dart';
import 'package:fireflutterr/information.dart';
import 'package:fireflutterr/registration.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBmy6q7ZWrqOW0ma-UsSKZB6pDDn7fweFY',
      appId: '1:531890766965:web:97f9516c636cb73feb243c',
      messagingSenderId: '531890766965',
      projectId: 'fireflutter-d7bd2',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        SignUp.routeName: (context) => const SignUp(),
        MyApp.routeName: (context) => MyHomePage(
              title: "asd",
            ),
        Photo.routeName: ((context) =>  Photo()),
        MainScreen.routeName: (context) => MainScreen(),
      },
      initialRoute: MyApp.routeName,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var acs = ActionCodeSettings(
    // URL you want to redirect back to. The domain (www.example.com) for this
    // URL must be whitelisted in the Firebase Console.
    url: 'https://fireflutterr.page.link/7Yohp',
    // This must be true
    handleCodeInApp: true,
    iOSBundleId: 'com.example.ios',
    androidPackageName: 'com.firefluterr.android',
    // installIfNotAvailable
    androidInstallApp: false,
    // minimumVersion
    androidMinimumVersion: '12');

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _verifyController = TextEditingController();
  String verificationid = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authorization'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email or phone';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) => ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(
                                content: Text("Успешная Авторизация"))))
                        .catchError((error) => ScaffoldMessenger.of(context)
                            .showSnackBar(
                                SnackBar(content: Text("Error: $error"))));
                                Navigator.pushNamed(context, MainScreen.routeName);
                    // Navigator.pushNamed(context, MainScreen.routeName);
                    //     .then((value) {
                    //       Navigator.pushNamed(context, MainScreen.routeName);
                    //   //print(value.user?.email);
                    //   //print(value.user?.uid);
                    // });
                  }
                },
                child: Text('Authorize'),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signInAnonymously().then((value) {
                    print(value.user?.uid);
                  });
                },
                child: Text('Anonymous'),
              ),

              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    //try {
                    await FirebaseAuth.instance.verifyPhoneNumber(
                      phoneNumber: _emailController.text,
                      codeSent:
                          (String verificationId, int? resendToken) async {
                        verificationid = verificationId;
                        //resendToken1 = resendToken;
                        var showSnackBar = ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            "SMS отправленo",
                          ),
                        ));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                      verificationCompleted:
                          (PhoneAuthCredential phoneAuthCredential) {},
                      verificationFailed: (FirebaseAuthException error) {},
                    );
                    // } on FirebaseAuthException catch (e) {
                    //   print(e);
                    // }
                  },
                  child: const Text('Send sms'),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: _verifyController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Smscode',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              Column(children: [
                ElevatedButton(
                  onPressed: () async {
                    // try {
// Update the UI - wait for the user to enter the SMS code
                    String smsCode = _verifyController.text;

// Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credentiall =
                        PhoneAuthProvider.credential(
                            verificationId: verificationid, smsCode: smsCode);

// Sign the user in (or link) with the credential
                    await FirebaseAuth.instance
                        .signInWithCredential(credentiall);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "${FirebaseAuth.instance.currentUser!.uid}, ${FirebaseAuth.instance.currentUser!.phoneNumber}",
                      ),
                    ));
                    // } on FirebaseAuthException catch (e) {
                    //   print(e);
                    // }
                  },
                  child: const Text('Verify phone'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Navigator.pushNamed(context, SignUp.routeName);
                  },
                  child: Text('Registration'),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ]),
              // ElevatedButton(
              //   onPressed: () async {
              //     await FirebaseAuth.instance
              //         .sendSignInLinkToEmail(
              //             email:
              //                 "ignatovnikita301203@gmail.com" /*_emailController.text*/,
              //             actionCodeSettings: acs)
              //         .catchError((onError) =>
              //             print('Error sending email verification $onError'))
              //         .then((value) =>
              //             print('Successfully sent email verification'));

              //     if (FirebaseAuth.instance.isSignInWithEmailLink(
              //         "https://fireflutterr.page.link/7Yohp")) {
              //       try {
              //         // The client SDK will parse the code from the link for you.
              //         final userCredential = await FirebaseAuth.instance
              //             .signInWithEmailLink(
              //                 email: "ignatovnikita301203@gmail.com",
              //                 emailLink:
              //                     "https://fireflutterr.page.link/7Yohp");

              //         // You can access the new user via userCredential.user.
              //         final emailAddress = userCredential.user?.email;

              //         print('Successfully signed in with email link!');
              //       } catch (error) {
              //         print('Error signing in with email link.');
              //       }
              //     }
              //   },
              //   child: Text('Email link'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
