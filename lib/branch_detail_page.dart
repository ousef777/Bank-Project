import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // To launch the URL

class BranchDetailPage extends StatelessWidget {
  final Map<String, dynamic> branch;

  BranchDetailPage({required this.branch});

  // Function to launch the URL in browser
  void _launchMap(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    // Main page structure with AppBar and body
    appBar: AppBar(
      // Displays branch name in the title
      title: Text('${branch['name']} Details'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Branch image
          Image.asset(
            'assets/images/burgan.jpg', 
            height: 150,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          
          // Displays branch address
          Text(
            'Location: ${branch['address']}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),

          // Displays branch opening hours
          Text(
            'Opening Hours: ${branch['openingHours']}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),

          // Displays contact information
          Text(
            'Contact: 1804080',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),

          // Google Maps button
          Text(
            'Map View',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            // Opens Google Maps with the branch location
            onPressed: () {
              _launchMap(branch['mapLink']);
            },
            icon: Icon(Icons.map),
            label: Text('View on Google Maps'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
          ),
        ],
      ),
    ),
  );
}
}