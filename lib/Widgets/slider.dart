import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class MyCircularSlider extends StatefulWidget {
  const MyCircularSlider({super.key});

  @override
  _MyCircularSliderState createState() => _MyCircularSliderState();
}

class _MyCircularSliderState extends State<MyCircularSlider> {
  double _value = 0.0;
  List<String> labels = [
    'sad',
    'melancholic',
    'happy',
    'super happy',
    'gaand faad'
  ];

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 150,
        startAngle: 150,
        angleRange: 240,
        customWidths: CustomSliderWidths(progressBarWidth: 30),
        customColors: CustomSliderColors(
          trackColor: Colors.grey[300],
          progressBarColors: [Colors.blue, Colors.green, Colors.yellow],
          dotColor: Colors.white,
          hideShadow: true,
        ),
        infoProperties: InfoProperties(
          mainLabelStyle: GoogleFonts.lato(
            textStyle: const TextStyle(color: Colors.blue, letterSpacing: .5),
          ),
        ),
      ),
      min: 0,
      max: 4,
      initialValue: _value,
      onChange: (double newValue) {
        setState(() {
          _value = newValue;
        });
      },
      innerWidget: (double value) {
        return Center(
          child: Text(
            labels[value.toInt()],
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        );
      },
    );
  }
}