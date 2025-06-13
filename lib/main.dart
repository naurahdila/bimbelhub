import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bimbelhub/screens/home_screen.dart';
import 'package:bimbelhub/screens/login_screen.dart';
import 'package:bimbelhub/theme/theme_provider.dart';
import 'package:bimbelhub/providers/favorites_provider.dart';
import 'package:bimbelhub/providers/chat_provider.dart';
import 'package:bimbelhub/providers/auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // Pindahkan checkAuthStatus ke initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_initialized) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.checkAuthStatus();
        _initialized = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Update status bar based on theme
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarColor: themeProvider.isDarkMode ? const Color(0xFF121212) : Colors.white,
            systemNavigationBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
          ),
        );

        return Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'BimbelHub',
              theme: themeProvider.isDarkMode 
                ? ThemeProvider.darkTheme.copyWith(
                    textTheme: ThemeProvider.darkTheme.textTheme.apply(fontFamily: 'Poppins'),
                    colorScheme: ThemeProvider.darkTheme.colorScheme.copyWith(
                      primary: const Color.fromARGB(255, 102, 182, 247),
                      secondary: const Color.fromARGB(255, 164, 208, 252),
                    ),
                  ) 
                : ThemeProvider.lightTheme.copyWith(
                    textTheme: ThemeProvider.lightTheme.textTheme.apply(fontFamily: 'Poppins'),
                    colorScheme: ThemeProvider.lightTheme.colorScheme.copyWith(
                      primary: const Color.fromARGB(255, 102, 182, 247),
                      secondary: const Color.fromARGB(255, 164, 208, 252),
                    ),
                  ),
              home: authProvider.isLoading
                  ? const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : authProvider.isAuthenticated
                      ? const HomeScreen()
                      : const LoginScreen(),
            );
          },
        );
      },
    );
  }
}
