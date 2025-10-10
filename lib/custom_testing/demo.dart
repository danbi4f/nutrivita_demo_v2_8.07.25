import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            var maxWidth = constraints.maxWidth;
            var maxHeight = constraints.maxHeight;
            return Container(
              color: Colors.grey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Icon(Icons.width_full),
                          Text('maxWidth: $maxWidth'),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(Icons.height),
                          Text('maxHeight: $maxHeight'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20, child: Text('space: 20 piksel')),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            color: Colors.red,
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(40),
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(width: 150, height: 150, color: Colors.black),
                    ],
                  ),
                  Expanded(
                    child: ListView.custom(
                      childrenDelegate: SliverChildBuilderDelegate((
                        context,
                        index,
                      ) {
                        return Container(
                          height: 100,
                          color: index.isEven ? Colors.blue : Colors.green,
                          alignment: Alignment.center,
                          child: Text('Item $index'),
                        );
                      }, childCount: 20),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
