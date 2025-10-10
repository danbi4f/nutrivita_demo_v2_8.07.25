import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: AnimatedDrawerDemo()));
}

class AnimatedDrawerDemo extends StatefulWidget {
  @override
  _AnimatedDrawerDemoState createState() => _AnimatedDrawerDemoState();
}

class _AnimatedDrawerDemoState extends State<AnimatedDrawerDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
  }

  void toggleDrawer() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double drawerWidth = 200;
    final double scaleDown = 0.55;
    final double shiftRight = 80;

    return Scaffold(
      backgroundColor: Color(0xFFD0F0C0).withOpacity(0.2), // Jasna mięta
      body: Stack(
        children: [
          // Drawer z efektem glassmorphism
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              double slide = -drawerWidth + (_controller.value * drawerWidth);
              return Transform.translate(
                offset: Offset(slide, 0),
                child: Container(
                  width: drawerWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Color(0xFFD0F0C0).withOpacity(0.2),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DrawerHeader(
                                child: Text(
                                  "Menu",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.home,
                                  color: Colors.black87,
                                ),
                                title: Text(
                                  "Strona główna",
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.settings,
                                  color: Colors.black87,
                                ),
                                title: Text(
                                  "Ustawienia",
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),

          // Tło przyciemnione po otwarciu drawer
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return _controller.value > 0
                  ? GestureDetector(
                    onTap: toggleDrawer,
                    child: Container(
                      color: Colors.black.withOpacity(0.2 * _controller.value),
                    ),
                  )
                  : SizedBox.shrink();
            },
          ),

          // Główny ekran z efektem glassmorphic
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final scale = 1 - (_controller.value * (1 - scaleDown));
              final shift = _controller.value * shiftRight;
              final radius = _controller.value * 25;

              return Transform(
                transform:
                    Matrix4.identity()
                      ..translate(shift)
                      ..scale(scale),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Color(0xFFD0F0C0).withOpacity(0.2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                        ),
                        boxShadow:
                            _controller.value > 0
                                ? [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 20,
                                  ),
                                ]
                                : [],
                      ),
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        appBar: AppBar(
                          title: Text("Aplikacja"),
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black87,
                          elevation: 0,
                          leading: IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: toggleDrawer,
                          ),
                        ),
                        body: Center(
                          child: Text(
                            "Treść główna aplikacji",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
