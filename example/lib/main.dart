/* This example demonstrates how to use MemValue with SharedPreferences in a Flutter application.
   A int memory value is defined and displayed in the app's home page.
  The value can be incremented using a floating action button and reset to its initial state using a refresh button in the app bar.
*/

import 'package:flutter/material.dart';
import 'package:mem_value/mem_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// [Step 1]
/// Define memory values. You can define them anywhere you want even as global variables.
class Mem {
  static final MemInt exampleValue = MemInt('example_key');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // [Step 2]
  // Setup MemValue storage using SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  MemValue.setStorage(
    MemStorageDelegate(
      readValue: (tag) async => prefs.getString(tag),
      writeValue: (tag, value) async => await prefs.setString(tag, value),
      deleteValue: (tag) async => await prefs.remove(tag),
    ),
  );

  // OR use Async version of SharedPreferences
  var prefAsync =
      SharedPreferencesAsync(options: const SharedPreferencesOptions());
  MemValue.setStorage(
    MemStorageDelegate(
      readValue: prefAsync.getString,
      writeValue: prefAsync.setString,
      deleteValue: prefAsync.remove,
    ),
  );

  // [Step 3] Load memory values before using them
  // Note: if you use 'read' or 'setValue', MemValue will automatically load.
  // 'Mem.exampleValue.value' property cannot be used without loading it first to avoid desynchronization.
  await Mem.exampleValue.load();

  // [Optional] You can also define a MemGroup to load all values together (or reset them together)
  var memGroup = MemGroup([Mem.exampleValue]);

  await memGroup.loadAll();
  // await memGroup.resetAll();
  // await memGroup.deleteAll();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MemValue Example"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              // Reset the exampleValue to its initial state
              await Mem.exampleValue.reset();
              setState(() {});
            },
          ),
        ],
      ),
      // Display the current value of exampleValue
      body: Center(
        child: Text('${Mem.exampleValue.value}'),
      ),

      // Floating action button to increment the exampleValue
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            // Increment the exampleValue by 1
            setState(() {
              Mem.exampleValue.value += 1;
            });
          }),
    );
  }
}
