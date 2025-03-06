import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'newsrules.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Row(
          children: [
            CircleAvatar(
              child: Text('JD'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        'Level 01',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '|',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '\$25.00',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Consumer<AppState>(
            builder: (context, appState, child) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Daily Reward Section
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            'Claim your Daily Reward',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Horizontal Scrollable Daily Rewards - matches prototype
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: () => appState.claimDailyReward(index),
                                  child: Container(
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: appState.dailyRewardClaimed[index]
                                          ? Colors.green.shade100
                                          : Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'D',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Tasks Section Title
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Do Tasks, Earn Reward',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'You can do these tasks as many times\nas you want to',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dynamic Task Cards - matches prototype
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final task = appState.dailyTasks[index];
                        return TaskCard(
                          title: task.name,
                          description: task.name == 'Merge Cooking'
                              ? 'Play Game'
                              : 'Read News',
                          reward: '\$${task.reward.toStringAsFixed(0)}',
                          completed: task.completed,
                          imageAsset: task.name == 'Merge Cooking'
                              ? 'assets/merge_cooking.png'
                              : 'assets/news_reading.png',
                          onTap: () {
                            if (!task.completed) {
                              if (task.name == 'Read News') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReadNewsRulesScreen(),
                                  ),
                                );
                              } else {
                                // Handle other tasks
                                appState.completeTask(task.name);
                              }
                            }
                          },
                        );
                      },
                      childCount: appState.dailyTasks.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              // Stay on home
              break;
            case 1:
              // Navigate to tasks
              break;
            case 2:
              // Navigate to profile
              break;
          }
        },
      ),
    );
  }
}

// Updated TaskCard to match prototype
class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String reward;
  final bool completed;
  final String imageAsset;
  final VoidCallback onTap;

  const TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.reward,
    required this.imageAsset,
    this.completed = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: completed ? null : onTap,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              // Left section with image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageAsset,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              // Middle section with title and description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              // Right section with reward
              Text(
                reward,
                style: TextStyle(
                  color: completed ? Colors.grey : Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
