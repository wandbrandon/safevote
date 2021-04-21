import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:safevote/models/election_model.dart';
import 'package:safevote/services/firestore_service.dart';
import 'login/login.dart';
import 'services/authentication_service.dart';
import 'voting/election_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirestoreService>(
            create: (context) => FirestoreService(FirebaseFirestore.instance)),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider<User?>(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
        FutureProvider<List<Election>>(
            create: (context) =>
                context.read<FirestoreService>().getAllElections(),
            initialData: List<Election>.empty())
      ],
      child: MaterialApp(
        title: 'SafeVoting',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: AuthenticationWrapper(),
        routes: {
          '/main_vote': (context) => ElectionList(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authUser = context.watch<User?>();
    if (authUser != null) {
      return ElectionList();
    }
    return LoginPage();
  }
}
