import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeColor {
  static Color main = Colors.blue;
  static Color secondary = Colors.blueAccent;
  static Color tertiary = Colors.indigo;
}

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

List<BottomNavigationBarItem> items = [
  BottomNavigationBarItem(
    icon: Icon(Icons.person, color: Colors.white),
    label: "Profile",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.home, color: Colors.white),
    label: "Home",
    backgroundColor: Colors.white,
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.settings, color: Colors.white),
    label: "Settings",
  ),
];
List<DropdownMenuEntry> menuEntries = [
  DropdownMenuEntry(
    value: [Colors.red, Colors.redAccent, CupertinoColors.destructiveRed],
    label: "Red",
  ),
  DropdownMenuEntry(
    value: [Colors.green, Colors.greenAccent, CupertinoColors.activeGreen],
    label: "Green",
  ),
  DropdownMenuEntry(
    value: [Colors.blueAccent, Colors.blueAccent, CupertinoColors.activeBlue],
    label: "Blue",
  ),
];
List<DropdownMenuEntry> fontStyles = [];

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text(
          "Settings Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ThemeColor.main,
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          Navigator.pushNamed(context, "/${items[index].label}");
        },
        items: items,
        backgroundColor: ThemeColor.main,
        selectedItemColor: CupertinoColors.activeBlue,
      ),

      body: Center(
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Theme: "),
                    DropdownMenu(
                      dropdownMenuEntries: menuEntries,
                      onSelected: (index) {
                        setState(() {
                          ThemeColor.main = index[0];
                          ThemeColor.secondary = index[1];
                          ThemeColor.tertiary = index[2];
                        });
                      },
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
