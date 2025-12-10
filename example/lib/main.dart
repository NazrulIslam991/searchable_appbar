// ====================================================================
// SECTION 2: Demo App and Filterable HomeScreen
// ====================================================================

import 'package:flutter/material.dart';
import 'package:searchable_appbar/searchable_appbar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Custom AppBar Demo',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // --- List Data ---
  final List<String> _allItems = [
    "Apple",
    "Banana",
    "Carrot",
    "Date",
    "Elderberry",
    "Fig",
    "Grape",
    "Honey",
    "Ice Cream",
    "Jelly",
    "Kiwi",
    "Lemon",
    "Mango",
    "Nectarine",
    "Orange",
    "Peach",
    "Quince",
    "Raspberry",
    "Strawberry",
    "Tomato",
    "Ugli Fruit",
    "Vanilla",
    "Watermelon",
    "Xigua (Chinese Watermelon)",
    "Yogurt",
    "Zucchini",
  ];
  List<String> _filteredItems = [];
  // -----------------

  final List<Tab> _myTabs = const [
    Tab(text: "Home"),
    Tab(text: "Profile"),
    Tab(text: "Settings"),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _myTabs.length, vsync: this);
    _filteredItems = List.from(_allItems); // Initialize with all items
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // --- Search/Filter Logic ---
  void _onSearchSubmitted(String query) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Search Submitted: ${query.trim()}')),
    );
    _filterList(query.trim());
  }

  void _onSearchChanged(String query) {
    _filterList(query);
  }

  void _filterList(String query) {
    final lowerCaseQuery = query.toLowerCase();

    setState(() {
      if (lowerCaseQuery.isEmpty) {
        _filteredItems = List.from(_allItems);
      } else {
        _filteredItems = _allItems
            .where((item) => item.toLowerCase().contains(lowerCaseQuery))
            .toList();
      }
    });
  }
  // ---------------------------

  void _onProfileSelected(dynamic value) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profile button clicked')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchableAppbar(
        title: "Dashboard",
        leadingIcon: Icons.menu,
        backgroundColor: Theme.of(context).colorScheme.primary,
        notificationCount: 7,
        profileAvatar: const CircleAvatar(
          radius: 14,
          backgroundColor: Colors.white,
          child: Text('P', style: TextStyle(color: Colors.blue)),
        ),
        onProfileMenuSelected: _onProfileSelected,
        onSearch: _onSearchSubmitted, // Submit/Enter key
        onChanged: _onSearchChanged, // Real-time filtering
        bottom: TabBar(
          controller: _tabController,
          tabs: _myTabs,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
        bottomShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Home Tab with Filterable List
          _buildFilterableList(),
          const Center(child: Text("Profile Content")),
          const Center(child: Text("Settings Content")),
        ],
      ),
    );
  }

  Widget _buildFilterableList() {
    if (_filteredItems.isEmpty) {
      return Center(
        child: Text(
          "No items found.",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.inventory),
          title: Text(_filteredItems[index]),
          subtitle: Text("Item ${index + 1}"),
        );
      },
    );
  }
}
