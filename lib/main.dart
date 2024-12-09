import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:property/repository/property_client.dart';
import 'feature/property/bloc/property_bloc.dart';
import 'feature/property/ui/home_screen.dart';
import 'repository/property_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyClient propertyClient = PropertyClient();
    final PropertyRepository propertyRepository =
        PropertyRepository(propertyClient);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PropertySearchBloc(propertyRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Property',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
