import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import FilteringTextInputFormatter here
import '../data/bg_data.dart'; // Ensure bgList is defined here
import '../utils/text_utils.dart'; // Ensure TextUtil is defined here
import '../widgets/toolbar.dart'; // Import your custom toolbar

class VerifyCodefpScreen extends StatefulWidget {
  const VerifyCodefpScreen({super.key});

  @override
  State<VerifyCodefpScreen> createState() => _VerifyCodefpScreenState();
}

class _VerifyCodefpScreenState extends State<VerifyCodefpScreen> {
  int selectedIndex = 0;
  final List<TextEditingController> _otpControllers = List.generate(5, (index) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(5, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    _otpControllers.asMap().forEach((index, controller) {
      controller.addListener(() {
        String value = controller.text;
        if (value.length == 1) {
          // Move to the next field if a digit is entered
          _focusNextField(index);
        } else if (value.isEmpty) {
          // Move to the previous field if the field is emptied
          _focusPreviousField(index);
        }
      });
    });
  }

  void _focusNextField(int index) {
    if (index < _otpControllers.length - 1) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
    }
  }

  void _focusPreviousField(int index) {
    if (index > 0) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              height: 450,
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
                          text: "Code Verification",
                          weight: true,
                          size: 30,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              width: 50,
                              child: TextFormField(
                                controller: _otpControllers[index],
                                focusNode: _otpFocusNodes[index],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.white, fontSize: 24),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.red,
                                  hintText: '_',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                  counterText: '', // Hide the counter text
                                ),
                                maxLength: 1,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    _focusNextField(index);
                                  }
                                },
                                onEditingComplete: () {
                                  if (_otpControllers[index].text.isEmpty) {
                                    _focusPreviousField(index);
                                  }
                                },
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 50), // Increased space between OTP fields and buttons
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/changepwd');
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
                        const SizedBox(height: 15),
                        TextUtil(
                          text: "Didn't receive your OTP code?",
                          size: 12,
                          weight: true,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            // Add functionality for resending code
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: TextUtil(
                              text: "Resend Code",
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

// AnimatedTriangles widget
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
