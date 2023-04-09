import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:only_facts/screens/facts_main.dart';
import 'package:only_facts/simple_bloc_observer.dart';

import 'bloc/bloc_facts/facts_bloc.dart';

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FactsBloc>(
          create: (context) => FactsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'OnlyFacts',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xffCDEAC0),
          secondaryHeaderColor: const Color(0xff828C51),
        ),
        home: FactsMain(),
      ),
    );
  }
}
