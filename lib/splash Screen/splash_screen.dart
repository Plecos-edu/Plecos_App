import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pleocs/dashboard/dashboard_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _ellipseController;

  late Animation<Offset> _bounceUp;
  late Animation<Offset> _bounceDown;
  late Animation<Offset> _logoShiftLeft;
  late Animation<double> _ellipseFadeOut;
  late Animation<double> _logoScale;

  bool _showLogo = false;
  List<bool> _lettersVisible = List.filled(6, false);

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _ellipseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _ellipseFadeOut = Tween<double>(begin: 1.5, end: 0.0).animate(
      CurvedAnimation(parent: _ellipseController, curve: Curves.easeOut),
    );

    _bounceUp = Tween<Offset>(
      begin: const Offset(0.45, 0.35),
      end: const Offset(0.45, -0.70),
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _bounceDown = Tween<Offset>(
      begin: const Offset(0.0, -0.35),
      end: const Offset(0.0, 0.70),
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.3, 0.55, curve: Curves.easeIn),
      ),
    );

    _logoShiftLeft = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-0.40, 0),
    ).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.6, 0.85, curve: Curves.easeInOut),
      ),
    );

    _logoScale = TweenSequence([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.2,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.2,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 25,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 40),
    ]).animate(_logoController);

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => _showLogo = true);
    _logoController.forward();

    Future.delayed(const Duration(milliseconds: 100), () {
      _ellipseController.forward();
    });

    Future.delayed(const Duration(milliseconds: 4200), () {
      _revealLettersOneByOne();
    });

    await Future.delayed(const Duration(seconds: 6));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  void _revealLettersOneByOne() {
    for (int i = 0; i < _lettersVisible.length; i++) {
      Future.delayed(Duration(milliseconds: 100 * i), () {
        setState(() {
          _lettersVisible[i] = true;
        });
      });
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _ellipseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: Color(0xFF013A57),
      letterSpacing: 0,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFE0FCFF),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(height: 50,),
            FadeTransition(
              opacity: _ellipseFadeOut,
              child: Image.asset(
                'assets/image/ellipse.png',
                width: 400,
                height: 80,
              ),
            ),

            if (_showLogo)
              AnimatedBuilder(
                animation: _logoController,
                builder: (_, __) {
                  final offset =
                      _bounceUp.value +
                      _bounceDown.value +
                      _logoShiftLeft.value;

                  double clipOpacity =
                      _logoController.value < 0.15
                          ? 1.0
                          : (_logoController.value < 0.25
                              ? 1.0 - ((_logoController.value - 0.15) / 0.1)
                              : 0.0);

                  Widget logo = ScaleTransition(
                    scale: _logoScale,
                    child: Image.asset(
                      'assets/image/logo.png',
                      width: 70,
                      height: 85,
                    ),
                  );

                  Widget clippedLogo = Stack(
                    alignment: Alignment.center,
                    children: [
                      logo,

                      if (clipOpacity > 0.0)
                        Opacity(
                          opacity: clipOpacity,
                          child: ClipOval(child: logo),
                        ),
                    ],
                  );

                  return Align(
                    alignment: Alignment.center,
                    child: Transform.translate(
                      offset: Offset(offset.dx * 180, offset.dy * 180),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          clippedLogo,
                          const SizedBox(width: 5),
                          Row(
                            children: List.generate(6, (i) {
                              return AnimatedOpacity(
                                opacity: _lettersVisible[i] ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                                child: Text("PLECOS"[i], style: textStyle),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
