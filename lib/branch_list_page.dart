import 'package:flutter/material.dart';
import 'branch_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchListPage extends StatelessWidget {
  final List<Map<String, dynamic>> branches = [
    {
      'name': 'Kuwait City Branch',
      'area': 'Kuwait City',
      'address': '123 Kuwait St, Kuwait City, Kuwait',
      'openingHours': 'Sunday - Thursday, 9:00 AM - 1:00 PM',
      'mapLink': 'https://g.co/kgs/EpSDESX'
    },
    {
      'name': 'Salmiya Branch',
      'area': 'Salmiya',
      'address': '456 Salmiya Ave, Salmiya, Kuwait',
      'openingHours': 'Sunday - Thursday, 9:00 AM - 1:00 PM',
      'mapLink': 'https://g.co/kgs/GfwLBg9'
    },
    {
      'name': 'Jabriya Branch',
      'area': 'Jabriya ',
      'address': '789 Jabriya St, Salmya, Kuwait',
      'openingHours': 'Sunday - Thursday, 9:00 AM - 1:00 PM',
      'mapLink': 'https://g.co/kgs/Pgi4irf'
    },
    {
      'name': 'Farwaniya Branch',
      'area': 'Farwaniya',
      'address': '321 Farwaniya Ave, Farwaniya, Kuwait',
      'openingHours': 'Sunday - Thursday, 9:00 AM - 1:00 PM',
      'mapLink': 'https://g.co/kgs/x74kphe'
    },
    {
      'name': 'Jahra Branch',
      'area': 'Jahra',
      'address': '654 Jahra Blvd, Jahra, Kuwait',
      'openingHours': 'Sunday - Thursday, 9:00 AM - 1:00 PM',
      'mapLink': 'https://g.co/kgs/QERPCpZ'
    },
    {
      'name': 'Fahaheel Branch',
      'area': 'Fahaheel',
      'address': '987 Fahaheel St, Fahaheel, Kuwait',
      'openingHours': 'Sunday - Thursday, 9:00 AM - 1:00 PM',
      'mapLink': 'https://g.co/kgs/jZuL1oQ'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Burgan Bank Branches', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: branches.length,
        itemBuilder: (context, index) {
          final branch = branches[index];
          return Card(
            elevation: 6,
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell( // Make the entire card clickable
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BranchDetailPage(branch: branch),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Branch Name
                    Text(
                      branch['name']!,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900, // Text color
                      ),
                    ),
                    SizedBox(height: 5),

                    // Branch Area
                    Text(
                      branch['area']!,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 15),

                    // Divider for design separation
                    Divider(color: Colors.blue.shade100, thickness: 1),

                    // Opening Hours
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.blue.shade700, size: 20),
                        SizedBox(width: 5),
                        Text(
                          'Opening Hours: ${branch['openingHours']}',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),

                    // Branch Address
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blue.shade700, size: 20),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            branch['address']!,
                            style: TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    // Google Maps Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.map, color: Colors.white),
                          label: Text('Open Map',
                          style: TextStyle(
                            color: Colors.white
                          ),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 49, 66, 255), // Button color for map
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            _launchURL(Uri.parse(branch['mapLink']));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Function to launch URL
  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}