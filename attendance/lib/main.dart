import 'package:attendance/provider/subjectDetails.dart';
import 'package:attendance/provider/timeTable.dart';
import 'package:attendance/provider/userDetails.dart';
import 'package:attendance/screens/subjectScreen.dart';
import 'package:attendance/widgets/subjectCard.dart';
import 'package:flutter/material.dart';

import './screens/login.dart';
import './screens/signUp.dart';
import 'screens/initialsubject.dart';
import 'screens/InitialclassDetails.dart';
import './screens/home.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(UserDetailsAdapter().typeId)) {
    Hive.registerAdapter(UserDetailsAdapter());
  }
  if (!Hive.isAdapterRegistered(SubjectDetailsAdapter().typeId)) {
    Hive.registerAdapter(SubjectDetailsAdapter());
  }
  if (!Hive.isAdapterRegistered(TimeTableAdapter().typeId)) {
    Hive.registerAdapter(TimeTableAdapter());
  }
  final user = await Hive.openBox<UserDetails>('UserDB');
  bool? _dataNotPresent = user.isEmpty;
  runApp( MyApp(
    checkingDataAvailable: _dataNotPresent,
  ));
}

class MyApp extends StatelessWidget {
  final bool? checkingDataAvailable;
  const MyApp({Key? key, this.checkingDataAvailable,}

  ) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: const TextTheme(
              headline3: TextStyle(
            color: Colors.black,
            fontSize: 14,
          )),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
          iconTheme: const IconThemeData(
            color: Colors.black,
            size: 24,
          )),
      routes: {
        '/': (_) {
          /* Future<int> check() async {
            final details = await Hive.openBox<UserDetails>('UserDB')
                .then((value) => value.values.length);
            return details;
          }

          check().then((value) {
            if (value < 1) {
              dataInserted = false;
            } else {
              dataInserted = true;
            }
          }); */
          /* bool dataInserted = false;

          Hive.openBox<UserDetails>('UserDB')
              .then((userValues) => userValues.values.isEmpty)
              .then((value) {
            print('thid is vl${value}');
            dataInserted = value;
            //value ? const ClassDetails() : const HomeScreen();
          }); */
          // return ClassDetails();
          
          

          if (checkingDataAvailable==true) {
            
            return const ClassDetails();
          } else {
            
            return const HomeScreen();
          }
          
        },

        SignUp.routeName: (_) => SignUp(),
        // ClassDetails.routeName: (_) => const ClassDetails(),
        Subject.routeName: (_) => const Subject(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        SubjectScreen.routeName: (_) => SubjectScreen(),
      },
    );
  }
}
