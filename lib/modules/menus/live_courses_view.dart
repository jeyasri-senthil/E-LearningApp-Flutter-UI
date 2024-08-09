import 'package:flutter/material.dart';

class LiveCoursesView extends StatefulWidget {
  static const String routeName = '/live-courses';

  const LiveCoursesView({super.key});

  @override
  _LiveCoursesViewState createState() => _LiveCoursesViewState();
}

class _LiveCoursesViewState extends State<LiveCoursesView> {
  final List<Map<String, dynamic>> events = [
    {
      'title': 'Live Data Science Bootcamp',
      'description': 'Join the live bootcamp to dive deep into Data Science with hands-on sessions.',
      'image': 'https://techietory.com/wp-content/uploads/2023/10/9.jpg', // Replace with actual image URL
      'date': 'August 10, 2024',
      'time': '2:00 PM',
      'isRegistered': false,
      'isLive': true, // This indicates that the event is currently live
    },
    {
      'title': 'Live Coding Workshop',
      'description': 'Join us for a live coding workshop where experts will teach the latest programming techniques.',
      'image': 'https://t4.ftcdn.net/jpg/04/63/37/51/360_F_463375173_vBKRkUbVoCuS9lpUmhdfCc13pprPr148.jpg',
      'date': 'August 15, 2024',
      'time': '3:00 PM',
      'isRegistered': false,
    },
    {
      'title': 'AI and ML Webinar',
      'description': 'Attend a live webinar on the advancements in AI and Machine Learning, featuring top industry professionals.',
      'image': 'https://miro.medium.com/v2/resize:fit:1200/1*g4664eiXZPnUH-hgeW_eqw.jpeg',
      'date': 'August 20, 2024',
      'time': '5:00 PM',
      'isRegistered': false,
    },
  ];

  void _showRegistrationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have registered successfully for the event.'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  events[index]['isRegistered'] = true;
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToLiveEvent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiveEventPreview()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Events'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final event = events[index];
            final isLive = event['isLive'] == true;

            return Card(
              elevation: isLive ? 8 : 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Rounded corners for the Card
                side: isLive ? const BorderSide(color: Colors.redAccent, width: 2) : BorderSide.none,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)), // Rounded corners for the Image
                    child: Stack(
                      children: [
                        Image.network(
                          event['image']!,
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                        if (isLive)
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'LIVE',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      event['title']!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      event['description']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      'Date: ${event['date']}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    child: Text(
                      'Time: ${event['time']}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLive
                        ? ElevatedButton(
                      onPressed: () {
                        _navigateToLiveEvent(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                      ),
                      child: const Text('Join Now'),
                    )
                        : ElevatedButton(
                      onPressed: event['isRegistered']!
                          ? null
                          : () {
                        _showRegistrationDialog(context, index);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: event['isRegistered']! ? Colors.grey : Colors.white70,
                      ),
                      child: Text(event['isRegistered']! ? 'Registered' : 'Register'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class LiveEventPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Event Preview'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.live_tv,
              size: 100,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              'You are watching the Live Data Science Bootcamp!',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
              child: const Text('Leave Event'),
            ),
          ],
        ),
      ),
    );
  }
}
