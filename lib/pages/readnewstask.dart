import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class ReadNewsTaskScreen extends StatefulWidget {
  @override
  _ReadNewsTaskScreenState createState() => _ReadNewsTaskScreenState();
}

class _ReadNewsTaskScreenState extends State<ReadNewsTaskScreen> {
  final List<NewsArticle> articles = [
    NewsArticle(
      title: 'Discover the 10 Best Hairstyles According to Your Face Shape',
      imageUrl: 'assets/hairstyles_article.jpg',
      author: 'Fashion Weekly',
    ),
    NewsArticle(
      title: 'Most Beautiful Things to Do in Sidney With Your Boyfriend',
      imageUrl: 'assets/sidney_article.jpg',
      author: 'Travel Insights',
    ),
    // Add more articles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Task', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                '10:00',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return _buildNewsArticleCard(articles[index]);
        },
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Implement claim logic
                final appState = Provider.of<AppState>(context, listen: false);
                appState.completeTask('Read News');
                Navigator.of(context).pushReplacementNamed('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                'Claim',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsArticleCard(NewsArticle article) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            article.imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  article.author,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NewsArticle {
  final String title;
  final String imageUrl;
  final String author;

  NewsArticle({
    required this.title,
    required this.imageUrl,
    required this.author,
  });
}
