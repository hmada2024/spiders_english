// screens/settings_page.dart
import 'package:flutter/material.dart';
import 'package:learn_box_english/database/database_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isCacheEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Cache Data in RAM'),
            trailing: Switch(
              value: _isCacheEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isCacheEnabled = value;
                  if (_isCacheEnabled) {
                    DatabaseHelper.enableCache();
                  } else {
                    DatabaseHelper.disableCache();
                  }
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Caching data in RAM...')),
              );
              final db = await DatabaseHelper().database;
              await DatabaseHelper.cacheDatabase(db);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data cached in RAM')),
              );
            },
            child: const Text('Load Data into RAM'),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: () {
              DatabaseHelper.clearCache();
              setState(() {
                _isCacheEnabled = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('RAM cache cleared')),
              );
            },
            child: const Text('Clear Data from RAM'),
          ),
        ],
      ),
    );
  }
}
