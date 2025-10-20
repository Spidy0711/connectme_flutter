import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/user_repository.dart';
import 'presentation/bloc/user_bloc.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const ConnectMeApp());
}

class ConnectMeApp extends StatelessWidget {
  const ConnectMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConnectMe',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (_) => UserBloc(UserRepository())..add(LoadUsers()),
        child: const HomeScreen(),
      ),
    );
  }
}
