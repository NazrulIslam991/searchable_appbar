import 'package:custom_appbar/custom_appbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search AppBar Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TabbedHomeScreen(),
    );
  }
}

class TabbedHomeScreen extends StatefulWidget {
  const TabbedHomeScreen({super.key});

  @override
  State<TabbedHomeScreen> createState() => _TabbedHomeScreenState();
}

class _TabbedHomeScreenState extends State<TabbedHomeScreen> {
  List<String> allItems = List.generate(50, (i) => "Home Content ${i + 1}");
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }

  /// ✅ LIVE filtering function: যখনই ইউজার সার্চবারে টাইপ করে
  void onSearchChanged(String query) {
    // সার্চ ক্যোয়ারি না থাকলে সব আইটেম দেখাও
    if (query.isEmpty) {
      setState(() {
        filteredItems = allItems;
      });
      return;
    }

    // ক্যোয়ারির উপর ভিত্তি করে আইটেম ফিল্টার করা
    setState(() {
      filteredItems = allItems
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  /// Submit search (optional)
  void onSearchSubmit(String query) {
    // Submit এর সময়ও আপনি চাইলে onSearchChanged কল করতে পারেন।
    // অথবা শুধু একটি মেসেজ দেখাতে পারেন।
    debugPrint("Search submitted: $query");
    // onSearchChanged(query); // যদি submit এ আলাদা করে ফিল্টার করার প্রয়োজন না হয়
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Search & Filter Demo",
        // ✅ onSearchChanged ফাংশনটি onChanged প্রপার্টিতে পাস করা হলো
        onChanged: onSearchChanged,
        onSearch: onSearchSubmit,
        hintText: "Search items...",
        // সার্চ বন্ধ না করে কন্টিনিউ রাখার জন্য
        keepSearchOpenAfterSubmit: true,
        backgroundColor: Theme.of(context).primaryColor,
        titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),

      // ✅ filteredItems লিস্টটি এখানে ব্যবহার করা হয়েছে
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                filteredItems[index],
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                'Result ${index + 1} of ${filteredItems.length}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          );
        },
      ),
    );
  }
}
