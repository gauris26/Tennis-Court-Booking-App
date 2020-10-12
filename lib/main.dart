import 'package:flutter/foundation.dart';
import 'features/domain_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'core/setup.dart';
import 'core/injectable.dart';

Future<void> main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupHive().then((value) {
    seed();
    setupLocator();
    runApp(App());
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: BlocProvider(
          create: (context) => ScheduleCubit(get<ICourtRepository>()),
          child: HomePage(),
        ),
      ),
    );
  }
}
