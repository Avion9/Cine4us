import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/Controllers/Screen_Controller.dart';

class BreathingButton extends StatefulWidget {
  final double scaleA, scaleB;
  const BreathingButton({
    super.key,
    required this.scaleA,
    required this.scaleB,
  });
  @override
  _BreathingButtonState createState() => _BreathingButtonState();
}

class _BreathingButtonState extends State<BreathingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final screenC = Get.find<ScreenController>();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation =
        Tween<double>(begin: widget.scaleA, end: widget.scaleB).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.stop(),
      onExit: (_) => _controller.repeat(reverse: true),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (_, child) {
              return Transform.scale(
                scale: _animation.value,
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 71, 217, 228),
                    spreadRadius: 1,
                    blurRadius: 20,
                  ),
                ],
              ),
              child: FloatingActionButton(
                onPressed: () {
                  Get.back();
                },
                splashColor: const Color.fromARGB(255, 71, 217, 228),
                backgroundColor: const Color.fromRGBO(110, 190, 196, 230),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: Colors.white, size: 20),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
