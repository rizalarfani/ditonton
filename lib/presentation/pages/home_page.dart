import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/search_page_movie.dart';
import 'package:ditonton/presentation/pages/search_page_tv.dart';
import 'package:ditonton/presentation/pages/tv_series_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/bottom_navigation_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          Consumer<BottomNavigationNotifier>(
            builder: (context, state, _) {
              return IconButton(
                onPressed: () {
                  if (state.currentIndex == 0) {
                    Navigator.pushNamed(context, SearchPageMovie.ROUTE_NAME);
                  } else {
                    Navigator.pushNamed(context, SearchPageTv.ROUTE_NAME);
                  }
                },
                icon: Icon(Icons.search),
              );
            },
          ),
        ],
      ),
      body: Consumer<BottomNavigationNotifier>(
        builder: (context, state, _) => IndexedStack(
          index: state.currentIndex,
          children: [
            HomeMoviePage(),
            TvSeriesPage(),
          ],
        ),
      ),
      bottomNavigationBar: Consumer<BottomNavigationNotifier>(
        builder: (context, state, _) => BottomNavigationBar(
          currentIndex: state.currentIndex,
          onTap: (value) => state.currentIndex = value,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_creation_outlined,
              ),
              label: 'Movie',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.tv_rounded,
              ),
              label: 'Tv Series',
            )
          ],
        ),
      ),
    );
  }
}
