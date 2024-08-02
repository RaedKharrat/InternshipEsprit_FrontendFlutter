import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget implements PreferredSizeWidget {
  const HeaderBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HalfCircleClipper(),
      child: Container(
        color: Colors.grey,
        height: preferredSize.height,
        child: Center(
          child: CustomPaint(
            size: const Size(70, 70), // Increase the size for better visibility
            painter: CircleWithTrianglePainter(),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}

class HalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.circular(size.width / 2),
      clockwise: false,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class CircleWithTrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0); // Add shadow

    // Draw circle with full opacity
    final circleCenter = Offset(size.width / 2, size.height / 2);
    final circleRadius = size.width / 2;
    canvas.drawCircle(circleCenter, circleRadius, circlePaint);

    final trianglePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // Create a path for the triangle and rotate it 90 degrees
    final path = Path()
      ..moveTo(size.width / 2, size.height / 6) // Adjust position for better appearance
      ..lineTo(size.width * 2 / 3, size.height * 2 / 3)
      ..lineTo(size.width / 3, size.height * 2 / 3)
      ..close();

    // Translate and rotate canvas to rotate the triangle
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(90 * 3.1415927 / 180); // Rotate 90 degrees
    canvas.translate(-size.width / 2, -size.height / 2);

    // Draw the rotated triangle
    canvas.drawPath(path, trianglePaint);
    canvas.restore();

    // Add a stronger shadow for the circle
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4.0);

    canvas.drawCircle(circleCenter.translate(3, 3), circleRadius, shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
