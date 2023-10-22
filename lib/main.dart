import 'package:flutter/material.dart';
import 'package:note_app/components/dialogs/create_note.dart';
import 'package:note_app/components/dialogs/not_signin.dart';
import 'package:note_app/components/loader.dart';
import 'package:note_app/components/note_list.dart';
import 'package:note_app/providers/auth_provider.dart';
import 'package:note_app/providers/loading_provider.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => NoteProvider()),
        ChangeNotifierProvider(create: (context) => LoadingProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),

      // child: Consumer(
      //   builder: (context, AuthProvider authProvider, child) {
      //     return MaterialApp(
      //       title: 'Flutter Demo',
      //       theme: ThemeData(
      //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      //         useMaterial3: true,
      //       ),
      //       home: const HomePage(),
      //     );
      //   },
      //         ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? uid;
  late AuthProvider authProvider;

  // _checkAuth() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   uid = prefs.getString('uid');
  //   setState(() {});
  //   // debugPrint(uid);
  // }

  // _onButtonPressed(AuthProvider authProvd) {
  //   _checkAuth();
  //   if (uid == null) {
  //     _showDialog(NotSigninAlert());
  //   } else {
  //     _showDialog(CreateNoteDialog());
  //   }
  // }

  _onButtonPressed(AuthProvider authProvd) async {
    final String? token = await authProvider.getTokenFromPrefs();

    if (token == null) {
      _showDialog(NotSigninAlert(
        auth: authProvd,
      ));
    } else {
      _showDialog(const CreateNoteDialog());
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      authProvider = Provider.of<AuthProvider>(context, listen: false);
      NoteProvider noteProvider =
          Provider.of<NoteProvider>(context, listen: false);

      String? token = await authProvider.getTokenFromPrefs();

      debugPrint("---- $token");
      if (token != null) {
        noteProvider.getNotes(token);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    authProvider = Provider.of<AuthProvider>(context);
    final loadingProvider = Provider.of<LoadingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        actions: [
          IconButton(
              onPressed: () async {
                authProvider.logout();
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  authProvider.token == null
                      ? const Text("You aren't signed in")
                      : const NoteList(),
                ],
              ),
            ),
          ),
          // ADD BUTTON
          Positioned(
            right: 35,
            bottom: 50,
            child: FloatingActionButton(
              backgroundColor: Colors.brown.shade400,
              onPressed: () {
                _onButtonPressed(authProvider);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          // Loader
          loadingProvider.loading ? const Loader() : Container()
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    authProvider.dispose();
  }

  _showDialog(Widget MyDialog) {
    showDialog(
        context: context,
        builder: (context) {
          return MyDialog;
        });
  }
}
