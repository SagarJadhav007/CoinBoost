import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coin_buddy/main.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                CircleAvatar(
                  child: Text('JD'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Level 01 | \$25.00',
                        style: TextStyle(fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
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
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Claim your Daily Reward',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),

                        // Horizontal Scrollable Daily Rewards
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
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: appState.dailyRewardClaimed[index]
                                          ? Colors.green.shade100
                                          : Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text('Day ${index + 1}'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Tasks Section Title
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Do Tasks, Earn Reward',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Dynamic Task Cards
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final task = appState.dailyTasks[index];
                        return TaskCard(
                          title: task.name,
                          description: 'Play Game',
                          reward: '\$${task.reward.toStringAsFixed(2)}',
                          completed: task.completed,
                          onTap: () {
                            if (!task.completed) {
                              appState.completeTask(task.name);
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
      ),
    );
  }
}

// Slightly modified TaskCard to be more responsive
class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String reward;
  final bool completed;
  final VoidCallback onTap;

  const TaskCard({
    Key? key,
    required this.title,
    required this.description,
    required this.reward,
    this.completed = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(
          completed ? Icons.check_circle : Icons.play_circle_outline,
          color: completed ? Colors.green : Colors.orange,
          size: 40,
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          reward,
          style: TextStyle(
            color: completed ? Colors.grey : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: completed ? null : onTap,
      ),
    );
  }
}
