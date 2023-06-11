import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final List<MentalHealthCure> mentalHealthCures = [
    MentalHealthCure(
      title: 'Mindful Meditation',
      description:
      'Practice mindfulness meditation daily to reduce stress and improve mental well-being. Find a quiet place, sit comfortably, and focus on your breath.',
    ),
    MentalHealthCure(
      title: 'Stress Relief',
      description:
      'Yoga helps reduce stress by activating the body relaxation response. Practices like Savasana (Corpse Pose), Balasana (Child Pose), and Pranayama (breathing exercises) can induce a state of deep relaxation.',
    ),
    MentalHealthCure(
      title: 'Anxiety Reduction',
      description:
      'Yoga can calm the mind and alleviate anxiety. Try practicing gentle yoga sequences, such as Sun Salutations (Surya Namaskar) or Yin Yoga, which involve slow, mindful movements and deep stretching.',
    ),
    MentalHealthCure(
      title: 'Improved Sleep',
      description:
      'Certain yoga poses and relaxation techniques can aid in better sleep. Consider incorporating practices like Legs-Up-The-Wall Pose (Viparita Karani), Forward Fold (Uttanasana), or meditation before bedtime to promote relaxation and prepare the body for restful sleep.',
    ),
    MentalHealthCure(
      title: 'Exercise Regularly',
      description:
      'Engage in physical activities like walking, running, or yoga to boost your mood, reduce anxiety, and enhance your overall mental health.',
    ),
    MentalHealthCure(
      title: 'Socialize and Connect',
      description:
      'Maintain healthy relationships and spend quality time with loved ones. Engaging in social activities can improve your mental well-being and provide support.',
    ),
    MentalHealthCure(
      title: 'Practice Gratitude',
      description:
      'Start a gratitude journal and write down three things you are grateful for every day. Cultivating gratitude can enhance positive emotions and mental resilience.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Community Post',
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        backgroundColor: Color.fromARGB(255, 187, 255, 255),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bgmed.png'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to Our Mental Health Community!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'We are here to support and uplift each other',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'About Our Community !',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Our mental health community is a safe and inclusive space where individuals can come together to share their experiences, seek support, and provide encouragement to one another. We believe in the power of community support and aim to create an environment that promotes understanding, empathy, and growth.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Text(
                  'Mental Health Cures',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: mentalHealthCures.length,
                  itemBuilder: (context, index) {
                    final mentalHealthCure = mentalHealthCures[index];
                    return MentalHealthCureCard(
                        mentalHealthCure: mentalHealthCure);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MentalHealthCure {
  final String title;
  final String description;

  MentalHealthCure({
    required this.title,
    required this.description,
  });
}

class MentalHealthCureCard extends StatelessWidget {
  final MentalHealthCure mentalHealthCure;

  MentalHealthCureCard({required this.mentalHealthCure});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Color.fromARGB(255, 150, 209, 255),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mentalHealthCure.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Text(
              mentalHealthCure.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}