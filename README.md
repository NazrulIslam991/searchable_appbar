# custom_appbar 🚀

| Pub.dev | License | Platform |
| :---: | :---: | :---: |
| [![pub package](https://img.shields.io/pub/v/custom_appbar.svg)](https://pub.dev/packages/custom_appbar) | [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE) | [![Platform](https://img.shields.io/badge/platform-flutter-blue.svg)](https://flutter.dev) |

A highly customizable Flutter `AppBar` widget with **built-in, animated search functionality**, automatic theme awareness, notification badges, and avatar support. Simplify your application header implementation with rich features out of the box.

---

## Features ✨

The `CustomAppBar` is designed to be a drop-in replacement for `AppBar`, offering enhanced capabilities for modern mobile applications:

* **Integrated Search:** Seamless transition between the title and a full-width **search text field** using a smooth cubic animation.
* **Live Filtering Support:** Provides dedicated `onChanged` and `onSearch` callbacks for implementing real-time list filtering.
* **Theme Awareness:** Automatically determines the appropriate text and icon colors (**White** for Dark/Colored backgrounds, **Black** for Light backgrounds) unless explicitly overridden.
* **Notification Badge:** Easily display dynamic, non-intrusive **notification counts** directly on the action icon.
* **Profile/Avatar Button:** Supports custom `Widget` for a profile picture or avatar in the actions list.
* **Customizable Layout:** Full control over `toolbarHeight`, `bottom` widget (e.g., `TabBar`), `bottomShape`, and `titleAlignment`.



---

## Getting started 📦

### Installation

1.  **Add the dependency** to your `pubspec.yaml` file:

    ```yaml
    dependencies:
      custom_appbar: ^0.1.0
    ```

2.  **Run `flutter pub get`** in your terminal.

### Prerequisites

* Flutter SDK: `>=3.0.0`
* Dart SDK: `>=2.18.0`

---

## Usage 💻

### 1. Basic Implementation (Search & Filtering)

To integrate the app bar and enable live search filtering on your list data, use the `onChanged` property:

```dart
import 'package:flutter/material.dart';
import 'package:custom_appbar/custom_appbar.dart'; // Assuming your custom class is here

class HomeScreen extends StatefulWidget {
  // ...
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> allItems = ['Apple', 'Banana', 'Cherry', 'Date'];
  List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = allItems;
  }
  
  // 💡 This function updates the list in real-time
  void onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredItems = allItems;
      } else {
        filteredItems = allItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Product Catalog",
        hintText: "Search fruits...",
        onChanged: onSearchChanged, // Passes query for live filtering
        keepSearchOpenAfterSubmit: true, // Keep search field active after hitting enter
        backgroundColor: Colors.deepPurple,
        notificationCount: 5,
      ),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(filteredItems[index]));
        },
      ),
    );
  }
}

You can easily integrate a TabBar by utilizing the bottom property, and customize the look and feel using various style properties.
// Example of using CustomAppBar with a TabBar
CustomAppBar(
  title: "Advanced Dashboard",
  titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  toolbarHeight: 65.0,
  backgroundColor: Theme.of(context).primaryColor,
  
  // Custom Icon/Text Colors
  leadingIconColor: Colors.yellow,
  actionIconColor: Colors.yellow,
  
  // Profile Avatar and Notification Badge
  notificationCount: 99, 
  profileAvatar: const CircleAvatar(
    radius: 12,
    child: Text('U'),
  ),
  onProfileMenuSelected: (value) => print('Profile button tapped'),

  // Custom Bottom Widget (TabBar)
  bottom: const TabBar(
    tabs: [
      Tab(text: 'Feed'), 
      Tab(text: 'Messages')
    ],
  ),
  // Custom Shape for the AppBar
  bottomShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(15),
    ),
  ),
),


Properties Reference
| Property                    | Type                   | Default       | Description                         |
| --------------------------- | ---------------------- | ------------- | ----------------------------------- |
| `title`                     | `String`               | `"App Title"` | Title when search is closed.        |
| `hintText`                  | `String?`              | `"Search..."` | Placeholder for search field.       |
| `onChanged`                 | `Function(String)?`    | `null`        | Fires on every search text change.  |
| `onSearch`                  | `Function(String)?`    | `null`        | Fires on search submit/enter.       |
| `notificationCount`         | `int`                  | `0`           | Shows a red notification badge.     |
| `profileAvatar`             | `Widget?`              | `null`        | A custom avatar/profile widget.     |
| `backgroundColor`           | `Color?`               | `null`        | AppBar background color.            |
| `leadingIconColor`          | `Color?`               | `auto`        | Auto-calculated from theme.         |
| `actionIconColor`           | `Color?`               | `auto`        | Auto-calculated from theme.         |
| `titleStyle`                | `TextStyle?`           | `null`        | Custom title style.                 |
| `bottom`                    | `PreferredSizeWidget?` | `null`        | Widget below AppBar (e.g., TabBar). |
| `bottomShape`               | `ShapeBorder?`         | `null`        | Custom shape for bottom corners.    |
| `keepSearchOpenAfterSubmit` | `bool`                 | `false`       | Keeps search active after submit.   |
| `toolbarHeight`             | `double`               | `56.0`        | Custom height.                      |
"

Additional information ℹ️
Reporting Issues: If you encounter any bugs or have feature requests, please file an issue on the GitHub repository.

Contributing: Contributions are welcome! Feel free to fork the repository and submit a pull request.

Version History: See the CHANGELOG.md for a complete history of changes.
