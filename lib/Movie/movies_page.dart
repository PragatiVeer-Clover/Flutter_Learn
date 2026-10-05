import 'package:flutter/material.dart';
import 'movie_model.dart';
import 'movie_service.dart';
import 'movie_detail.dart';
import 'my_tickets_page.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> with SingleTickerProviderStateMixin {
  late TabController _tabs;
  final _searchCtrl = TextEditingController();
  bool _searching = false;
  List<Movie> _searchResults = [];
  bool _searchLoading = false;

  final _tabs_labels = ['Trending', 'Popular', 'Top Rated', 'Upcoming'];
  final _futures = <Future<List<Movie>>>[];

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 4, vsync: this);
    _futures.addAll([
      MovieService.fetchTrending(),
      MovieService.fetchPopular(),
      MovieService.fetchTopRated(),
      MovieService.fetchUpcoming(),
    ]);
  }

  void _onSearch(String q) async {
    if (q.trim().isEmpty) {
      setState(() { _searching = false; _searchResults = []; });
      return;
    }
    setState(() { _searching = true; _searchLoading = true; });
    final results = await MovieService.search(q);
    setState(() { _searchResults = results; _searchLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: _searching
            ? TextField(
                controller: _searchCtrl,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search movies...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                onChanged: _onSearch,
              )
            : Row(children: [
                const Icon(Icons.movie_filter, color: Colors.redAccent, size: 28),
                const SizedBox(width: 8),
                const Text('CineWorld',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
              ]),
        actions: [
          IconButton(
            icon: const Icon(Icons.confirmation_num, color: Colors.redAccent),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MyTicketsPage())),
          ),
          IconButton(
            icon: Icon(_searching ? Icons.close : Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                _searching = !_searching;
                if (!_searching) { _searchCtrl.clear(); _searchResults = []; }
              });
            },
          ),
        ],
        bottom: _searching
            ? null
            : TabBar(
                controller: _tabs,
                isScrollable: true,
                indicatorColor: Colors.redAccent,
                labelColor: Colors.redAccent,
                unselectedLabelColor: Colors.grey,
                tabs: _tabs_labels.map((t) => Tab(text: t)).toList(),
              ),
      ),
      body: _searching
          ? _searchLoading
              ? const Center(child: CircularProgressIndicator(color: Colors.redAccent))
              : _searchResults.isEmpty
                  ? const Center(child: Text('No results found', style: TextStyle(color: Colors.grey)))
                  : _grid(_searchResults)
          : TabBarView(
              controller: _tabs,
              children: _futures.map((f) => FutureBuilder<List<Movie>>(
                future: f,
                builder: (context, snap) {
                  if (snap.connectionState == ConnectionState.waiting)
                    return const Center(child: CircularProgressIndicator(color: Colors.redAccent));
                  if (!snap.hasData || snap.data!.isEmpty)
                    return const Center(child: Text('No movies found', style: TextStyle(color: Colors.grey)));
                  return _grid(snap.data!);
                },
              )).toList(),
            ),
    );
  }

  Widget _grid(List<Movie> movies) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: LayoutBuilder(builder: (context, constraints) {
          final cols = constraints.maxWidth > 900 ? 5 : constraints.maxWidth > 600 ? 4 : 3;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              childAspectRatio: 0.55,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: movies.length,
            itemBuilder: (context, i) => _MovieCard(movie: movies[i]),
          );
        }),
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;
  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => MovieDetailPage(movie: movie))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    movie.posterUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (_, child, progress) => progress == null
                        ? child
                        : Container(color: const Color(0xFF1A1A1A),
                            child: const Center(child: CircularProgressIndicator(color: Colors.redAccent, strokeWidth: 2))),
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFF1A1A1A),
                      child: const Icon(Icons.movie, color: Colors.grey, size: 40),
                    ),
                  ),
                  // Rating badge
                  Positioned(
                    top: 8, right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 2),
                        Text(movie.rating.toStringAsFixed(1),
                            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
          Text(movie.year, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        ],
      ),
    );
  }
}
