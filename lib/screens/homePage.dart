import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../screens/reclamations.dart'; // Correct the import path
import '../screens/absence_page.dart'; // Import the AbsencePage
import '../screens/emplois.dart'; // Import the EmploisPage
import '../screens/displayCahierClass.dart'; // Import the CahierdeclassForm
import '../screens/evaluationsChart.dart'; // Import the EvaluationsChart
import '../widgets/toolbar.dart'; // Ensure you import the custom toolbar
import '../widgets/header.dart'; // Import the HeaderBar

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = -1;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> boxItems = [
      {'text': 'Emplois du temps', 'icon': Icons.calendar_today},
      {'text': 'Cahier de classe', 'icon': Icons.book},
      {'text': 'Absence', 'icon': Icons.remove_circle},
      {'text': 'Reclamations', 'icon': Icons.report},
      {'text': 'Evaluations', 'icon': Icons.assessment},
    ];

    final List<Color> borderColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];

    return Scaffold(
     // appBar:  HedhahouwaAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg111.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AnimatedTriangles(),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                   
                    const SizedBox(height: 10),
                    Text(
                      '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 300.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      aspectRatio: 2.0,
                      viewportFraction: 0.6,
                    ),
                    items: boxItems.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> item = entry.value;
                      return Builder(
                        builder: (BuildContext context) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                                _isPressed = true;
                              });
                              Future.delayed(const Duration(milliseconds: 200), () {
                                setState(() {
                                  _isPressed = false;
                                });
                                // Navigate to the respective page based on item['text']
                                if (item['text'] == 'Reclamations') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ReclamationsScreen(),
                                    ),
                                  );
                                } else if (item['text'] == 'Absence') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AbsencePage(),
                                    ),
                                  );
                                } else if (item['text'] == 'Emplois du temps') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EmploisPage(),
                                    ),
                                  );
                                } else if (item['text'] == 'Cahier de classe') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DisplayCahierClass(),
                                    ),
                                  );
                                } else if (item['text'] == 'Evaluations') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EvaluationsChart(),
                                    ),
                                  );
                                }
                              });
                            },
                            child: AnimatedScale(
                              scale: _selectedIndex == index && _isPressed ? 0.95 : 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: _selectedIndex == index && _isPressed ? 220 : 200,
                                height: _selectedIndex == index && _isPressed ? 220 : 200,
                                decoration: BoxDecoration(
                                  color: _selectedIndex == index && _isPressed
                                      ? Colors.red.withOpacity(0.7)
                                      : Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: borderColors[index % borderColors.length],
                                    width: 3,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
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
                                        item['icon'] as IconData,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        item['text'] as String,
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
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 80.0),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CustomToolbar(),
          ),
        ],
      ),
    );
  }
}

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
                    size: const Size(100, 100),
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

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
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
