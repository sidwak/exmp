import 'package:exm_p/screens/creator/creatorhome_screen.dart';
import 'package:exm_p/screens/creator/creatorlogin_screen.dart';
import 'package:exm_p/screens/creator/creatorsignup_screen.dart';
import 'package:exm_p/screens/follower/followerhome_screen.dart';
import 'package:exm_p/screens/follower/followerlogin_screen.dart';
import 'package:exm_p/screens/follower/followersignup_screen.dart';
import 'package:flutter/material.dart';
import 'package:exm_p/screens/main/mainlogin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: MainLoginScreen.id,
      routes: {
        MainLoginScreen.id: (context) => MainLoginScreen(),
        CreatorLoginScreen.id: (context) => CreatorLoginScreen(),
        CreatorSignupScreen.id: (context) => CreatorSignupScreen(),
        FollowerLoginScreen.id: (context) => FollowerLoginScreen(),
        FollowerSignupScreen.id:(context) => FollowerSignupScreen(),
        CreatorHomeScreen.id: (context) => CreatorHomeScreen(),
        FollowerHomeScreen.id: (context) => FollowerHomeScreen()
      },
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
