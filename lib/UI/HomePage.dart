import 'package:flutter/material.dart';
import 'package:st_task/Bloc/article_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = [
    Colors.blueGrey[100],
    Colors.pink[50],
    Colors.teal[50],
    Colors.white.withOpacity(0.8)
  ];

  final articlebloc = ArticlesBloc();

  @override
  void initState() {
    super.initState();
    articlebloc.fetchAllArticles();
  }

  @override
  void dispose() {
    articlebloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Top Stories")),
      body: StreamBuilder(
        stream: articlebloc.allArticles,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Fetching the latest articles..."),
            );
          } else if (snapshot.hasData) {
            return articleList(snapshot);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget articleList(snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.articles.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.black, width: 2)),
            borderOnForeground: true,
            color: colors[index % 4],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 25, bottom: 10),
                  child: Text(
                      "by ${snapshot.data.articles[index].author == null || snapshot.data.articles[index].author == "" ? 'Jeff Smith' : snapshot.data.articles[index].author}",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 14,
                          fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                        snapshot.data.articles[index].urlToImage == null
                            ? "https://i.imgur.com/XOvOKx0.jpg"
                            : snapshot.data.articles[index].urlToImage,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 40,
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, bottom: 30, right: 25),
                  child: Text(snapshot.data.articles[index].title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
