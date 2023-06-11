import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InstantCare extends StatefulWidget {
  const InstantCare({super.key});

  @override
  State<InstantCare> createState() => _InstantCareState();
}

class _InstantCareState extends State<InstantCare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: MentalHelplineScreen());
  }
}

class MentalHelplineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Instant Care",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            HelplineCard(
              title: 'National Suicide Prevention Lifeline',
              number: '1-800-273-8255',
              context: context,
            ),
            HelplineCard(
              title: 'Crisis Text Line',
              number: '741741',
              context: context,
            ),
            HelplineCard(
              title: 'Veterans Crisis Line',
              number: '1-800-273-8255 (Press 1)',
              context: context,
            ),
            HelplineCard(
              title: 'SAMHSA National Helpline',
              number: '1-800-662-HELP (4357)',
              context: context,
            ),
            HelplineCard(
              title: 'Vandrevala Foundation Helpline',
              number: '1860-2662-345 / 1800-2333-330',
              context: context,
            ),
            HelplineCard(
              title: 'Roshni Helpline (for Suicide Prevention)',
              number: '+91-40-6620-2000 / +91-40-6620-2001',
              context: context,
            ),
            HelplineCard(
              title: 'Saath Helpline (Ahmedabad)',
              number: '91-79-2630-5544 / +91-79-2630-0222',
              context: context,
            ),
            HelplineCard(
              title: 'Sumaitri Helpline (Delhi)',
              number: '+9123389090',
              context: context,
            ),
            HelplineCard(
              title: 'Sanjivini Society for Mental Health (Chennai)',
              number: '+91-984-011-2345 /+91-984-011-2345',
              context: context,
            ),
            HelplineCard(
              title: 'Parivarthan Helpline (Bangalore)',
              number: '+91-767-660-2602',
              context: context,
            ),
            HelplineCard(
              title: 'Vandrevala Foundation (Mumbai)',
              number: '+91-730-459-9836 / +91-730-459-9837',
              context: context,
            ),
          ])),
    );
  }
}

class HelplineCard extends StatelessWidget {
  final String title;
  final String number;
  final BuildContext context;

  HelplineCard(
      {required this.title, required this.number, required this.context});

  void _launchDialer() async {
    final url = 'tel:$int(number)';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      // // showDialog(
      // //   context: context,
      // //   builder: (context) {
      // //     return AlertDialog(
      // //       title: Text('Error'),
      // //       content: Text('Could not launch the dialer.'),
      // //       actions: [
      // //         TextButton(
      // //           onPressed: () {
      // //             Navigator.pop(context);
      // //           },
      // //           child: Text('OK'),
      // //         ),
      // //       ],
      // //     );
      //   },
      // )
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[300],
      elevation: 2.0,
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(number),
        leading: Icon(Icons.phone),
        onTap: _launchDialer,
      ),
    );
  }
}