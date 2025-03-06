import 'package:coin_buddy/pages/newsrules.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'pages/homescreen.dart';
import 'pages/loading.dart';
import 'pages/onboarding.dart';
import 'pages/readnewstask.dart';
import 'pages/reward.dart';

// State Management
class AppState extends ChangeNotifier {
  String? _phoneNumber;
  int _userLevel = 1;
  double _balance = 25.00;
  List<TaskProgress> _dailyTasks = [
    TaskProgress('Merge Cooking', false, 10.0),
    TaskProgress('Read News', false, 5.0),
  ];
  List<bool> _dailyRewardClaimed = List.filled(7, false);
  List<RewardLevel> _rewardLevels = [
    RewardLevel(
      level: 1,
      minimumEarnings: 500,
      isUnlocked: true,
    ),
    RewardLevel(
      level: 2,
      minimumEarnings: 1000,
      isUnlocked: false,
    ),
    RewardLevel(
      level: 3,
      minimumEarnings: 1500,
      isUnlocked: false,
    ),
  ];

  String? get phoneNumber => _phoneNumber;
  int get userLevel => _userLevel;
  double get balance => _balance;
  List<TaskProgress> get dailyTasks => _dailyTasks;
  List<bool> get dailyRewardClaimed => _dailyRewardClaimed;
  List<RewardLevel> get rewardLevels => _rewardLevels;

  void setPhoneNumber(String number) {
    _phoneNumber = number;
    notifyListeners();
  }

  void completeTask(String taskName) {
    final taskIndex = _dailyTasks.indexWhere((task) => task.name == taskName);
    if (taskIndex != -1) {
      _dailyTasks[taskIndex].completed = true;
      _balance += _dailyTasks[taskIndex].reward;

      // Check if task can unlock next reward level
      if (_balance >= _rewardLevels[_userLevel].minimumEarnings) {
        _unlockNextLevel();
      }

      notifyListeners();
    }
  }

  void _unlockNextLevel() {
    if (_userLevel < _rewardLevels.length - 1) {
      _userLevel++;
      _rewardLevels[_userLevel].isUnlocked = true;
    }
  }

  void claimDailyReward(int day) {
    if (!_dailyRewardClaimed[day]) {
      _dailyRewardClaimed[day] = true;
      _balance += 5.0; // Example reward amount
      notifyListeners();
    }
  }

  void claimRewardLevel(int level) {
    if (_rewardLevels[level - 1].isUnlocked) {
      // Add reward claiming logic
      _balance += level * 100.0; // Example reward calculation
      notifyListeners();
    }
  }
}

// Task Progress Model
class TaskProgress {
  String name;
  bool completed;
  double reward;

  TaskProgress(this.name, this.completed, this.reward);
}

// Reward Level Model
class RewardLevel {
  final int level;
  final int minimumEarnings;
  bool isUnlocked;

  RewardLevel({
    required this.level,
    required this.minimumEarnings,
    this.isUnlocked = false,
  });
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: CoinBoostApp(),
    ),
  );
}

class CoinBoostApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinBoost',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/read-news-rules': (context) => ReadNewsRulesScreen(),
        '/read-news-task': (context) => ReadNewsTaskScreen(),
        '/rewarding-levels': (context) => RewardingLevelsScreen(),
      },
    );
  }
}

// Bottom Navigation Bar Widget - updated to match prototype
class CoinBoostBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const CoinBoostBottomNavigationBar({
    Key? key,
    this.currentIndex = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.orange,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white54,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
