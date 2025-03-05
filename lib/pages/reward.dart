import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coin_buddy/main.dart';

class RewardingLevelsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Rewarding Levels', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: appState.rewardLevels.length,
            itemBuilder: (context, index) {
              final rewardLevel = appState.rewardLevels[index];
              return _buildRewardLevelCard(context, appState, rewardLevel);
            },
          );
        },
      ),
      bottomNavigationBar: CoinBoostBottomNavigationBar(
        currentIndex: 1, // Tasks tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacementNamed('/home');
              break;
            case 1:
              // Already on Tasks/Levels screen
              break;
            case 2:
              // Navigate to Profile screen if implemented
              break;
          }
        },
      ),
    );
  }

  Widget _buildRewardLevelCard(
      BuildContext context, AppState appState, RewardLevel rewardLevel) {
    final isUnlocked = rewardLevel.isUnlocked;
    final currentBalance = appState.balance;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Level ${rewardLevel.level}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isUnlocked ? Colors.orange : Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Minimum Earnings: ${rewardLevel.minimumEarnings}',
              style: TextStyle(color: Colors.black87),
            ),
            SizedBox(height: 8),
            Text(
              'Your earnings: ${currentBalance.toStringAsFixed(2)}',
              style: TextStyle(color: Colors.black54),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isUnlocked
                  ? () {
                      appState.claimRewardLevel(rewardLevel.level);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Reward for Level ${rewardLevel.level} claimed!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: isUnlocked ? Colors.orange : Colors.grey,
              ),
              child: Text(isUnlocked ? 'Claim Reward' : 'Locked'),
            ),
          ],
        ),
      ),
    );
  }
}
