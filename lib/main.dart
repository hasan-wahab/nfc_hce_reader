import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('hce.channel');
  final TextEditingController _idController =
  TextEditingController(text: "USER12345");

  void _sendIdToHce() async {
    try {
      final result = await platform.invokeMethod(
        "setData",
        {"data": _idController.text},
      );
      if (result == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("ID sent to HCE!")));
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: ${e.message}")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("HCE ID Sender")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: "Enter your ID",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendIdToHce,
              child: const Text("Send ID to HCE"),
            ),
          ],
        ),
      ),
    );
  }
}
