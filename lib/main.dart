import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:phonebook/core/constants/api.dart';
import 'package:phonebook/presentation/screens/authentication/login_page/login_screen.dart';
import 'package:phonebook/presentation/screens/contact_list/contact_screen.dart';
import 'package:phonebook/presentation/widgets/themes/appthemes.dart';
import 'package:phonebook/presentation/widgets/themes/theme_cubit.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await dotenv.load(fileName: "api_key.env");
  String apiToken = dotenv.env['api_key'] ?? '';

  await Supabase.initialize(url: url, anonKey: apiToken);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            title: 'Phone Book App',
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            
            themeMode: themeMode,
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
