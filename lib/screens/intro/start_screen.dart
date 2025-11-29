import 'package:ewallet_app/screens/auth/welcome.dart';
import 'package:ewallet_app/screens/home.dart';
import 'package:ewallet_app/screens/intro/intro_screen.dart';
import 'package:ewallet_app/ui/layouts/general_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final String _key = 'finishedIntro';
  bool _isFinishedIntro = false;
  bool _isAuthenticated = false;
  bool _isLoading = true;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final finishedIntro = prefs.getBool(_key) ?? false;
    final token = prefs.getString('authToken') ?? '';

    // If user is already authenticated, skip intro automatically.
    if (token.isNotEmpty && !finishedIntro) {
      await prefs.setBool(_key, true);
    }

    setState(() {
      _isFinishedIntro = finishedIntro || token.isNotEmpty;
      _isAuthenticated = token.isNotEmpty;
      _isLoading = false;
    });
  }

  Future<void> _saveIntroStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool(_key, true);
    setState(() {
      _isFinishedIntro = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isFinishedIntro) {
      return IntroScreen(saveIntroStatus: () {
        _saveIntroStatus();
      });
    }

    if (_isAuthenticated) {
      return const GeneralLayout(content: Home());
    }

    return const GeneralLayout(content: Welcome());
  }
}
