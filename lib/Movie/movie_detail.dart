import 'package:flutter/material.dart';
import 'movie_model.dart';
import 'ticket_booking_page.dart';
import 'video_player_page.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;
  const MovieDetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final genres = movie.genreIds
        .map((id) => genreMap[id] ?? '')
        .where((g) => g.isNotEmpty)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                backgroundColor: const Color(0xFF0A0A0A),
                iconTheme: const IconThemeData(color: Colors.white),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        movie.backdropUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Container(color: const Color(0xFF1A1A1A)),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Color(0xFF0A0A0A)],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              movie.posterUrl,
                              width: 120, height: 180, fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 120, height: 180,
                                color: const Color(0xFF1A1A1A),
                                child: const Icon(Icons.movie, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(movie.title,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                Row(children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 18),
                                  const SizedBox(width: 4),
                                  Text(movie.rating.toStringAsFixed(1),
                                      style: const TextStyle(
                                          color: Colors.amber, fontSize: 16, fontWeight: FontWeight.bold)),
                                  const Text('/10', style: TextStyle(color: Colors.grey, fontSize: 13)),
                                ]),
                                const SizedBox(height: 8),
                                if (movie.year.isNotEmpty)
                                  Row(children: [
                                    const Icon(Icons.calendar_today, color: Colors.grey, size: 14),
                                    const SizedBox(width: 4),
                                    Text(movie.releaseDate,
                                        style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                  ]),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8, runSpacing: 6,
                                  children: genres.map((g) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
                                    ),
                                    child: Text(g,
                                        style: const TextStyle(color: Colors.redAccent, fontSize: 12)),
                                  )).toList(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      const Text('Overview',
                          style: TextStyle(
                              color: Colors.redAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(
                        movie.overview.isNotEmpty ? movie.overview : 'No overview available.',
                        style: const TextStyle(color: Colors.white70, fontSize: 15, height: 1.6),
                      ),
                      const SizedBox(height: 28),

                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1A1A1A),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _stat(Icons.star_rate, movie.rating.toStringAsFixed(1), 'Rating'),
                            _stat(Icons.calendar_month, movie.year, 'Year'),
                            _stat(Icons.category, genres.isNotEmpty ? genres.first : 'N/A', 'Genre'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Buttons row
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => VideoPlayerPage(movieTitle: movie.title))),
                              icon: const Icon(Icons.play_circle_fill, color: Colors.redAccent),
                              label: const Text('Watch Now',
                                  style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.redAccent),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => TicketBookingPage(movie: movie))),
                              icon: const Icon(Icons.confirmation_num, color: Colors.white),
                              label: const Text('Book Ticket',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stat(IconData icon, String value, String label) {
    return Column(children: [
      Icon(icon, color: Colors.redAccent, size: 22),
      const SizedBox(height: 6),
      Text(value,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
    ]);
  }
}
