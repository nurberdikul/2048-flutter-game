import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double speed = 1.0;
  bool soundOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sound"),
                Switch(
                  value: soundOn,
                  onChanged: (value) {
                    setState(() {
                      soundOn = value;
                    });
                  },
                  activeThumbColor: Colors.blue, // исправлено deprecated activeColor
                ),
              ],
            ),
            SizedBox(height: 20),
            Text("Game Speed"),
            Slider(
              min: 0.5,
              max: 2.0,
              value: speed,
              onChanged: (value) {
                setState(() {
                  speed = value;
                });
              },
              activeColor: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
