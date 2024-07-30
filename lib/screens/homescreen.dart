// ignore_for_file: library_private_types_in_public_api
import 'package:covid_19_tracking_app/services/service.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/covid_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<CovidData> futureCovidData;

  @override
  void initState() {
    super.initState();
    futureCovidData = ApiService().fetchCovidData();
  }

  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const StatisticsScreen(),
    const DailyCheckupScreen(),
    const SelfQuarantineScreen(),
    const ProfileScreen(isHealthy: false),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 160, 65),
        title: const Text(
          'COVID-19 Tracker',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Add action for menu icon if needed
          },
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(Icons.bar_chart, color: Color.fromARGB(255, 60, 160, 65)),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle,
                color: Color.fromARGB(255, 60, 160, 65)),
            label: 'Daily Checkup',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 60, 160, 65)),
            label: 'Self Quarantine',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 60, 160, 65)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 60, 160, 65),
        onTap: _onItemTapped,
      ),
    );
  }
}

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  late Future<CovidData> futureCovidData;

  @override
  void initState() {
    super.initState();
    futureCovidData = ApiService().fetchCovidData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CovidData>(
      future: futureCovidData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 173, 216, 230),
                    leading: const Icon(Icons.coronavirus,
                        color: Color.fromARGB(255, 60, 160, 65)),
                    title: const Text('Cases',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${data.cases}'),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 173, 216, 230),
                    leading: const Icon(Icons.dangerous,
                        color: Color.fromARGB(255, 60, 160, 65)),
                    title: const Text('Deaths',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${data.deaths}'),
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    tileColor: const Color.fromARGB(255, 173, 216, 230),
                    leading: const Icon(Icons.healing,
                        color: Color.fromARGB(255, 60, 160, 65)),
                    title: const Text('Recovered',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${data.recovered}'),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 5,
                  child: Container(
                    height: 200,
                    padding: const EdgeInsets.all(8.0),
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.blue,
                            value: data.cases.toDouble(),
                            title: 'Cases',
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: data.deaths.toDouble(),
                            title: 'Deaths',
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          PieChartSectionData(
                            color: Colors.green,
                            value: data.recovered.toDouble(),
                            title: 'Recovered',
                            radius: 50,
                            titleStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class SelfQuarantineScreen extends StatelessWidget {
  const SelfQuarantineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 60, 160, 65),
        title: const Text(
          'Self Quarantine',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Self Quarantine Guidelines',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Follow these guidelines to ensure a safe and effective self-quarantine:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ListTile(
              leading:
                  Icon(Icons.home, color: Color.fromARGB(255, 60, 160, 65)),
              title: Text('Stay Home'),
              subtitle: Text(
                  'Do not leave your house unless it is absolutely necessary.'),
            ),
            ListTile(
              leading:
                  Icon(Icons.person, color: Color.fromARGB(255, 60, 160, 65)),
              title: Text('Separate Yourself'),
              subtitle: Text(
                  'Stay in a separate room and use a separate bathroom if possible.'),
            ),
            ListTile(
              leading: Icon(Icons.cleaning_services,
                  color: Color.fromARGB(255, 60, 160, 65)),
              title: Text('Clean Hands Often'),
              subtitle: Text(
                  'Wash your hands frequently with soap and water for at least 20 seconds.'),
            ),
            ListTile(
              leading:
                  Icon(Icons.masks, color: Color.fromARGB(255, 60, 160, 65)),
              title: Text('Wear a Mask'),
              subtitle:
                  Text('Wear a mask if you need to be around other people.'),
            ),
            ListTile(
              leading: Icon(Icons.local_pharmacy,
                  color: Color.fromARGB(255, 60, 160, 65)),
              title: Text('Monitor Your Symptoms'),
              subtitle: Text(
                  'Contact your healthcare provider if you have any concerning symptoms.'),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyCheckupScreen extends StatefulWidget {
  const DailyCheckupScreen({super.key});

  @override
  _DailyCheckupScreenState createState() => _DailyCheckupScreenState();
}

class _DailyCheckupScreenState extends State<DailyCheckupScreen> {
  bool hasFever = false;
  bool hasCough = false;
  bool hasFatigue = false;
  bool hasDifficultyBreathing = false;
  bool isHealthy = false;

  void _checkHealthStatus() {
    if (!hasFever && !hasCough && !hasFatigue && !hasDifficultyBreathing) {
      setState(() {
        isHealthy = true;
      });
    } else {
      setState(() {
        isHealthy = false;
      });
    }
  }

  void _submitHealthStatus() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(isHealthy: isHealthy),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Checkup',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 60, 160, 65), // Green color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CheckboxListTile(
              title: const Text('Fever'),
              value: hasFever,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    hasFever = value;
                    _checkHealthStatus();
                  });
                }
              },
            ),
            CheckboxListTile(
              title: const Text('Cough'),
              value: hasCough,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    hasCough = value;
                    _checkHealthStatus();
                  });
                }
              },
            ),
            CheckboxListTile(
              title: const Text('Fatigue'),
              value: hasFatigue,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    hasFatigue = value;
                    _checkHealthStatus();
                  });
                }
              },
            ),
            CheckboxListTile(
              title: const Text('Difficulty Breathing'),
              value: hasDifficultyBreathing,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    hasDifficultyBreathing = value;
                    _checkHealthStatus();
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 60, 160, 65), // Green color
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                setState(() {
                  hasFever = false;
                  hasCough = false;
                  hasFatigue = false;
                  hasDifficultyBreathing = false;
                  isHealthy = true;
                });
                _submitHealthStatus();
              },
              child: const Text(
                'Not experiencing any of them',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            if (isHealthy)
              const Text(
                'Congratulations! You\'re healthy!',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              )
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final bool isHealthy;

  const ProfileScreen({super.key, required this.isHealthy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 60, 160, 65), // Green color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              isHealthy ? 'Healthy User' : 'Quarantined User',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isHealthy ? Colors.blue : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please take care of your health',
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
