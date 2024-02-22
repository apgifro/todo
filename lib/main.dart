import 'package:flutter/material.dart';
import 'package:todo/view/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ToDo());
}

class ToDo extends StatelessWidget {
  const ToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do',
      debugShowCheckedModeBanner: false,
      home: const MainScreen(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.light(primary: Colors.blue),
      ),
    );
  }
}
