import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:snow_login/utils/animations.dart';
import '../data/bg_data.dart';
import '../utils/text_utils.dart';
import 'homepage.dart'; // Import the HomePage

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  bool showOption = false;
  bool _isPressed = false;

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
                    ? ShowUpAnimation(
                        delay: 100,
                        child: ListView.builder(
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
                                      backgroundImage:
                                          AssetImage(bgList[index]),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : const SizedBox()),
            const SizedBox(
              width: 20,
            ),
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
                    ))
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
                  )
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
                'assets/logoEsprit copy.png', // Update the path to your logo asset
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Center(
                          child: Column(
                            children: [
                              TextUtil(
                                text: "Sign In",
                                weight: true,
                                size: 30,
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        const Spacer(),
                        TextUtil(
                          text: "Email",
                        ),
                        Container(
                          height: 35,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white))),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(color: Colors.white70),
                              suffixIcon: Icon(
                                Icons.mail,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextUtil(
                          text: "Password",
                        ),
                        Container(
                          height: 35,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white))),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.white70),
                              suffixIcon: Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              fillColor: Colors.white,
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            const SizedBox(width: 10,),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/forgetpassword');
                                },
                                child: TextUtil(
                                  text: "* Forget Your Password ?",
                                  size: 10,
                                  weight: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        AnimatedScale(
                          scale: _isPressed ? 0.95 : 1.0,
                          duration: const Duration(milliseconds: 100),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isPressed = true;
                              });
                              Future.delayed(const Duration(milliseconds: 100), () {
                                setState(() {
                                  _isPressed = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const HomePage()),
                                );
                              });
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
                                text: "Log In",
                                color: Colors.black,
                              ),
                            ),
                            splashColor: Colors.black.withOpacity(0.2), // Ripple effect color
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
