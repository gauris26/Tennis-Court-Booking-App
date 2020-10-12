import 'features/booking/controller/home_controller.dart';
import 'features/booking/state/court_booking_cubit.dart';
import 'draft/repository/i_court_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'draft/services/setup.dart';
import 'core/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await setupHive();
  await seed();
  runApp(App());
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
