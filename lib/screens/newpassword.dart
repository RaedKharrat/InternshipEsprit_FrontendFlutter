import 'dart:ui';
import 'package:flutter/material.dart';
import '../data/bg_data.dart'; // Ensure bgList is defined here
import '../utils/text_utils.dart'; // Ensure TextUtil is defined here
import 'login_screen.dart'; // Import your LoginScreen

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  int selectedIndex = 0;
  bool showOption = false;
  bool _obscureText1 = true; // Toggle for the first password field
  bool _obscureText2 = true; // Toggle for the confirm password field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: showOption
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: bgList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: selectedIndex == index
                                ? Colors.white
                                : Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage(bgList[index]),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            ),
            const SizedBox(width: 20),
            showOption
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = true;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(bgList[selectedIndex]),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgList[selectedIndex]),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Animated triangles in the background
          AnimatedTriangles(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/logoEsprit copy.png', // Ensure the path is correct
                height: 60, // Adjust the height as needed
              ),
            ),
          ),
          Center(
            child: Container(
              height: 400,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Spacer(),
                        TextUtil(
                          text: "Reinitialize Password",
                          weight: true,
                          size: 30,
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.white)),
                          ),
                          child: TextFormField(
                            obscureText: _obscureText1,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Enter your new password',
                              hintStyle: const TextStyle(color: Colors.white70),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText1 ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText1 = !_obscureText1;
                                  });
                                },
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          height: 35,
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.white)),
                          ),
                          child: TextFormField(
                            obscureText: _obscureText2,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Confirm your new password',
                              hintStyle: const TextStyle(color: Colors.white70),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText2 ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText2 = !_obscureText2;
                                  });
                                },
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/homepage');
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: TextUtil(
                              text: "Confirm",
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15), // Add space between buttons
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            style: OutlinedButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(color: Colors.white),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: TextUtil(
                              text: "Back to Login",
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
    _animation = Tween<double>(begin: -100, end: 250).animate(_controller);
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
