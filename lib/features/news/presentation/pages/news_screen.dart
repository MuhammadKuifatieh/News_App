import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/news/news_bloc.dart';
import '../widgets/news_card.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = "news_screen";
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late NewsBloc newsBloc;
  @override
  void initState() {
    newsBloc = NewsBloc()..add(GetNewsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "News",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 28),
        ),
      ),
      body: BlocProvider(
        create: (context) => newsBloc,
        child: BlocBuilder<NewsBloc, NewsState>(
          bloc: newsBloc,
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15) +
                      const EdgeInsets.only(top: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      hintText: "Search",
                    ),
                    onChanged: (text) {
                      newsBloc.add(
                        GetNewsEvent(
                          isReload: true,
                          query: text,
                        ),
                      );
                    },
                  ),
                ),
                if (state.newsStatus == NewsStatus.init ||
                    (state.newsStatus == NewsStatus.loading &&
                        state.news.isEmpty))
                  const Expanded(
                    child: SizedBox(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                else if (state.newsStatus == NewsStatus.falied &&
                    state.news.isEmpty)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "something wrong happened",
                        ),
                        TextButton(
                          onPressed: () {
                            newsBloc.add(
                              GetNewsEvent(isReload: true),
                            );
                          },
                          child: const Text("Retry"),
                        )
                      ],
                    ),
                  )
                else if (state.news.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text("no news to show it"),
                    ),
                  )
                else
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        newsBloc.add(GetNewsEvent(isReload: true));
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        itemCount:
                            state.news.length + (state.isEndPage ? 0 : 1),
                        itemBuilder: (context, index) {
                          if (state.news.length == index) {
                            newsBloc.add(GetNewsEvent());
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return NewsCard(
                            news: state.news[index],
                          );
                        },
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
