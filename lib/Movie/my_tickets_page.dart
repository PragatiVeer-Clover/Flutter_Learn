import 'package:flutter/material.dart';
import 'ticket_model.dart';

class MyTicketsPage extends StatefulWidget {
  const MyTicketsPage({super.key});

  @override
  State<MyTicketsPage> createState() => _MyTicketsPageState();
}

class _MyTicketsPageState extends State<MyTicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Row(children: [
          Icon(Icons.confirmation_num, color: Colors.redAccent),
          SizedBox(width: 8),
          Text('My Tickets', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ]),
        actions: [
          if (myTickets.isNotEmpty)
            TextButton.icon(
              onPressed: () => setState(() => myTickets.clear()),
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              label: const Text('Clear', style: TextStyle(color: Colors.redAccent)),
            ),
        ],
      ),
      body: myTickets.isEmpty
          ? const Center(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.confirmation_num_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 16),
                Text('No tickets booked yet', style: TextStyle(color: Colors.grey, fontSize: 18)),
                SizedBox(height: 8),
                Text('Go book a movie!', style: TextStyle(color: Colors.grey, fontSize: 14)),
              ]),
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: myTickets.length,
                  itemBuilder: (context, i) {
                    final t = myTickets[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          // Top: movie info
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                                child: Image.network(
                                  t.movie.posterUrl,
                                  width: 80, height: 110, fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    width: 80, height: 110, color: Colors.grey[800],
                                    child: const Icon(Icons.movie, color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(t.movie.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                      const SizedBox(height: 8),
                                      _infoRow(Icons.calendar_today, t.date),
                                      const SizedBox(height: 4),
                                      _infoRow(Icons.access_time, t.time),
                                      const SizedBox(height: 4),
                                      _infoRow(Icons.event_seat, t.seats.join(', ')),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    const Icon(Icons.confirmation_num, color: Colors.redAccent),
                                    const SizedBox(height: 4),
                                    Text('\$${t.totalPrice.toStringAsFixed(2)}',
                                        style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Dashed divider
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: List.generate(30, (_) => Expanded(
                                child: Container(
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.3),
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                ),
                              )),
                            ),
                          ),
                          // Bottom: booking time
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Booked at ${t.bookedAt.hour}:${t.bookedAt.minute.toString().padLeft(2, '0')}',
                                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
                                  ),
                                  child: const Text('Confirmed',
                                      style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  Widget _infoRow(IconData icon, String text) => Row(children: [
        Icon(icon, color: Colors.grey, size: 13),
        const SizedBox(width: 6),
        Expanded(
          child: Text(text,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              overflow: TextOverflow.ellipsis),
        ),
      ]);
}
