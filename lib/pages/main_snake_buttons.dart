import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class MainSnakeButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Snake buttons'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SnakeButton(
              child: Text('Hello world'),
              onTap: () {
                print('on tap');
              },
            ),
            const SizedBox(
              height: 25,
            ),
            SnakeButton(
              snakeColor: Colors.red,
              borderWidth: 3,
              duration: const Duration(seconds: 3),
              child: Text('Hola mundo'),
              onTap: () {
                print('on tap');
              },
            ),
            const SizedBox(
              height: 25,
            ),
            SnakeButton(
              snakeColor: Colors.black,
              borderColor: Colors.green,
              borderWidth: 8,
              duration: const Duration(seconds: 1),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Dont touch me'),
              ),
              onTap: () {
                print('on tap');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SnakeButton extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback onTap;

  const SnakeButton(
      {Key key,
      this.onTap,
      this.child,
      this.duration,
      this.snakeColor = Colors.purple,
      this.borderColor = Colors.white,
      this.borderWidth = 4.0})
      : super(key: key);

  @override
  _SnakeButtonState createState() => _SnakeButtonState();
}

class _SnakeButtonState extends State<SnakeButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration ??
            const Duration(
              milliseconds: 1500,
            ));
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: CustomPaint(
        painter: _SnakePainter(
          animation: _controller,
          borderColor: widget.borderColor,
          borderWidth: widget.borderWidth,
          snakeColor: widget.snakeColor,
        ),
        child: Container(
          alignment: Alignment.center,
          child:
              Padding(padding: const EdgeInsets.all(15.0), child: widget.child),
        ),
      ),
    );
  }
}

class _SnakePainter extends CustomPainter {
  final Animation animation;
  final Color snakeColor;
  final Color borderColor;
  final double borderWidth;

  _SnakePainter({
    @required this.animation,
    this.snakeColor,
    this.borderColor,
    this.borderWidth,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [
          snakeColor,
          Colors.transparent,
        ],
        stops: [0.7, 1.0],
        startAngle: 0.0,
        endAngle: vector.radians(80),
        transform: GradientRotation(vector.radians(360 * animation.value)),
      ).createShader(rect);

    final path = Path.combine(PathOperation.xor, Path()..addRect(rect),
        Path()..addRect(rect.deflate(borderWidth)));

    canvas.drawRect(
        rect.deflate(borderWidth / 2),
        Paint()
          ..strokeWidth = borderWidth
          ..color = borderColor
          ..style = PaintingStyle.stroke);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
