import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(index.toString()),
            ),
            title: Text('Item $index'),
            subtitle: Text('Subtitle for item $index'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Handle tap
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Tapped on item $index')));
            },
          ),
        );
      },
    );
  }
}
