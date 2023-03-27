import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({Key key}) : super(key: key);

  @override
  _MeditationScreenState createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> {
  bool _isPlaying = false;
  Icon _icon = Icon(Icons.play_arrow);
  static AudioCache cache = AudioCache();
  AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    void playHandler(String string) {
      if (_isPlaying) {
        player.stop();
      } else {
        player = cache.load('audio/meditate1.mp3') as AudioPlayer;
      }
      debugPrint(string);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
        ),
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            //360, 290, 200, 360
            //190, 310, 190, 310
            AnimatedCircle(2, 190, Colors.purple, 470, 470, 570, 290),
            AnimatedCircle(3, 190, Colors.purple[300], 360, 290, 200, 360),
            AnimatedCircle(5, 190, Colors.purple[200], 190, 310, 190, 310),

            AnimatedCircle(5, 180, Colors.amber, 470, 470, 570, 290),
            AnimatedCircle(2, 180, Colors.amber[200], 360, 290, 200, 360),
            AnimatedCircle(3, 180, Colors.amber[100], 190, 310, 190, 310),

            AnimatedCircle(3, 170, Colors.pink, 470, 470, 570, 290),
            AnimatedCircle(5, 170, Colors.pink[300], 360, 290, 200, 360),
            AnimatedCircle(2, 170, Colors.pink[100], 190, 310, 190, 310),
            Center(
              child: CircleAvatar(
                radius: 84,
                backgroundColor: Colors.white,
                child: IconButton(
                  color: Colors.black,
                  iconSize: 130,
                  icon: _icon,
                  onPressed: () {
                    if (_isPlaying == true) {
                      setState(() {
                        _isPlaying = false;
                        _icon = Icon(Icons.play_arrow);
                      });
                    } else {
                      setState(() {
                        _isPlaying = true;
                        _icon = Icon(Icons.pause);
                      });
                    }
                    playHandler("I'm playing");
                    debugPrint(
                        "button pressed , value of isplaying is $_isPlaying");
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

class AnimatedCircle extends StatefulWidget {
  final int d;
  final double h;
  final Color color;
  final double t;
  final double r;
  final double l;
  final double b;
  AnimatedCircle(this.d, this.h, this.color, this.t, this.b, this.l, this.r);

  @override
  _AnimatedCircleState createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isPlaying = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: widget.d),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController,
      child:
          Blob(widget.h, widget.color, widget.t, widget.r, widget.l, widget.b),
      alignment: Alignment.center,
    );
  }

  Blob(double h, Color color, double t, double r, double l, double b) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: h,
            width: h,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(t),
                  topRight: Radius.circular(r),
                  bottomLeft: Radius.circular(l),
                  bottomRight: Radius.circular(b),
                )),
          ),
        ],
      ),
    );
  }
}
