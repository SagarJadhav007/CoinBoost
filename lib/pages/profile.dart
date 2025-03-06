import 'package:coin_buddy/pages/reward.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Avatar and Name Section
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          'JD',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        appState.phoneNumber ?? 'No phone number',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32),

                // Stats Card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Stats',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        _buildStatRow(
                          'Current Level',
                          'Level ${appState.userLevel}',
                          Icons.arrow_upward,
                        ),
                        Divider(),
                        _buildStatRow(
                          'Balance',
                          '\$${appState.balance.toStringAsFixed(2)}',
                          Icons.account_balance_wallet,
                        ),
                        Divider(),
                        _buildStatRow(
                          'Completed Tasks',
                          appState.dailyTasks
                              .where((task) => task.completed)
                              .length
                              .toString(),
                          Icons.check_circle,
                        ),
                        Divider(),
                        _buildStatRow(
                          'Rewards Claimed',
                          appState.dailyRewardClaimed
                              .where((claimed) => claimed)
                              .length
                              .toString(),
                          Icons.card_giftcard,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Level Progress Card
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Level Progress',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        if (appState.userLevel < appState.rewardLevels.length)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Progress to Level ${appState.userLevel + 1}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: appState.balance /
                                    appState.rewardLevels[appState.userLevel]
                                        .minimumEarnings,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.orange),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Earn \$${(appState.rewardLevels[appState.userLevel].minimumEarnings - appState.balance).toStringAsFixed(2)} more to reach Level ${appState.userLevel + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ],
                          )
                        else
                          Text(
                            'You have reached the maximum level!',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24),

                // Account Settings
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text('Edit Profile'),
                          trailing: Icon(Icons.chevron_right),
                          onTap: () {
                            // Edit profile logic
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text('Notifications'),
                          trailing: Switch(
                            value: true,
                            onChanged: (value) {
                              // Toggle notifications
                            },
                            activeColor: Colors.orange,
                          ),
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text('Logout'),
                          onTap: () {
                            // Logout logic
                            Navigator.of(context)
                                .pushReplacementNamed('/onboarding');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Profile tab
        backgroundColor: Colors.orange,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/home');
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RewardingLevelsScreen(),
                ),
              );
              break;
            case 2:
              // Already on profile page
              break;
          }
        },
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange),
          SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(fontSize: 14),
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
