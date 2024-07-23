import 'package:flutter/material.dart';
import '../screens/reclamations.dart'; // Correct the import path
import '../screens/absence_page.dart'; // Import the AbsencePage
import '../widgets/toolbar.dart'; // Ensure you import the custom toolbar

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // List of text and corresponding icons for each box
    final List<Map<String, dynamic>> boxItems = [
      {'text': 'Schedules', 'icon': Icons.calendar_today},
      {'text': 'Class Notebook', 'icon': Icons.book},
      {'text': 'Absence', 'icon': Icons.remove_circle},
      {'text': 'Assessment', 'icon': Icons.assessment},
      {'text': 'Reclamations', 'icon': Icons.report},
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg1.png'), // Update the path if necessary
                fit: BoxFit.cover, // Adjust as needed
              ),
            ),
          ),
          // Animated triangles in the background
          AnimatedTriangles(),
          // Column for logo, text, and boxes
          Column(
            children: [
              // Logo and text at the top
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logoEsprit copy.png', // Update with the correct path
                      height: 60, // Adjust the height as needed
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Welcome to teachers space Mr. Jack 👋🏻',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Expanded grid view to fill the remaining space
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 20.0,
                    children: List.generate(boxItems.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          if (boxItems[index]['text'] == 'Reclamations') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ReclamationsScreen(),
                              ),
                            );
                          } else if (boxItems[index]['text'] == 'Absence') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AbsencePage(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5), // Decreased opacity
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5), // Slightly darker shadow
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  boxItems[index]['icon'] as IconData,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  boxItems[index]['text'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          // Toolbar at the bottom
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomToolbar(), // Add your toolbar here
          ),
        ],
      ),
    );
  }
}

// AnimatedTriangles widget to create a moving triangles effect
class AnimatedTriangles extends StatefulWidget {
  @override
  _AnimatedTrianglesState createState() => _AnimatedTrianglesState();
}

class _AnimatedTrianglesState extends State<AnimatedTriangles> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -100, end: 300).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: List.generate(10, (index) {
          return AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                left: _animation.value + (index * 100.0),
                top: (index % 2 == 0) ? 0 : 50,
                child: Opacity(
                  opacity: 0.5,
                  child: CustomPaint(
                    size: Size(100, 100), // Size of the triangle
                    painter: TrianglePainter(),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Custom painter to draw triangles
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.3) // Triangle color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
