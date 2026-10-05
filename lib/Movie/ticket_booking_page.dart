import 'package:flutter/material.dart';
import 'movie_model.dart';
import 'ticket_model.dart';
import 'my_tickets_page.dart';

class TicketBookingPage extends StatefulWidget {
  final Movie movie;
  const TicketBookingPage({super.key, required this.movie});

  @override
  State<TicketBookingPage> createState() => _TicketBookingPageState();
}

class _TicketBookingPageState extends State<TicketBookingPage> {
  String _selectedDate = '';
  String _selectedTime = '';
  final Set<String> _selectedSeats = {};

  final List<String> _times = ['10:00 AM', '1:00 PM', '4:00 PM', '7:00 PM', '10:00 PM'];
  final Set<String> _bookedSeats = {'A3', 'B5', 'C2', 'C3', 'D7', 'E1', 'F4', 'F5'};

  final List<String> _rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
  final int _cols = 8;

  double get _total => _selectedSeats.length * ticketPrice;

  List<String> _nextDays() {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final d = now.add(Duration(days: i));
      final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      final days = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
      return '${days[d.weekday % 7]} ${d.day} ${months[d.month - 1]}';
    });
  }

  void _confirmBooking() {
    if (_selectedDate.isEmpty || _selectedTime.isEmpty || _selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select date, time and at least one seat.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final ticket = Ticket(
      movie: widget.movie,
      date: _selectedDate,
      time: _selectedTime,
      seats: _selectedSeats.toList()..sort(),
      totalPrice: _total,
      bookedAt: DateTime.now(),
    );
    myTickets.add(ticket);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(children: [
          Icon(Icons.check_circle, color: Colors.greenAccent),
          SizedBox(width: 8),
          Text('Booking Confirmed!', style: TextStyle(color: Colors.white)),
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.movie.title,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            _dialogRow(Icons.calendar_today, _selectedDate),
            _dialogRow(Icons.access_time, _selectedTime),
            _dialogRow(Icons.event_seat, _selectedSeats.toList()..sort(), isSeats: true),
            const Divider(color: Colors.grey, height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text('Total Paid', style: TextStyle(color: Colors.grey)),
              Text('\$${_total.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
            ]),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const MyTicketsPage()));
            },
            child: const Text('My Tickets', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _dialogRow(IconData icon, dynamic value, {bool isSeats = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Icon(icon, color: Colors.redAccent, size: 16),
        const SizedBox(width: 8),
        Text(
          isSeats ? (value as List).join(', ') : value,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final days = _nextDays();
    if (_selectedDate.isEmpty) _selectedDate = days.first;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Book Ticket', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            Text(widget.movie.title,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
                overflow: TextOverflow.ellipsis),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.confirmation_num, color: Colors.redAccent),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const MyTicketsPage())),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date picker
                      _sectionTitle('Select Date'),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: days.length,
                          itemBuilder: (_, i) {
                            final d = days[i];
                            final selected = d == _selectedDate;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedDate = d),
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: selected ? Colors.redAccent : const Color(0xFF1A1A1A),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: selected ? Colors.redAccent : Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(d.split(' ')[0],
                                        style: TextStyle(
                                            color: selected ? Colors.white : Colors.grey,
                                            fontSize: 11)),
                                    Text(d.split(' ')[1],
                                        style: TextStyle(
                                            color: selected ? Colors.white : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Time picker
                      _sectionTitle('Select Time'),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: _times.map((t) {
                          final selected = t == _selectedTime;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedTime = t),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                              decoration: BoxDecoration(
                                color: selected ? Colors.redAccent : const Color(0xFF1A1A1A),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: selected ? Colors.redAccent : Colors.grey.withOpacity(0.3),
                                ),
                              ),
                              child: Text(t,
                                  style: TextStyle(
                                      color: selected ? Colors.white : Colors.grey,
                                      fontWeight: selected ? FontWeight.bold : FontWeight.normal)),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 28),

                      // Screen indicator
                      _sectionTitle('Select Seats'),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.redAccent.withOpacity(0.0), Colors.redAccent.withOpacity(0.4), Colors.redAccent.withOpacity(0.0)],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text('SCREEN', style: TextStyle(color: Colors.white70, fontSize: 12, letterSpacing: 4)),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Seat grid
                      ...(_rows.map((row) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              child: Text(row, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(_cols, (col) {
                                  final seat = '$row${col + 1}';
                                  final booked = _bookedSeats.contains(seat);
                                  final selected = _selectedSeats.contains(seat);
                                  return GestureDetector(
                                    onTap: booked ? null : () {
                                      setState(() {
                                        if (selected) _selectedSeats.remove(seat);
                                        else _selectedSeats.add(seat);
                                      });
                                    },
                                    child: Container(
                                      width: 32,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: booked
                                            ? Colors.grey[800]
                                            : selected
                                                ? Colors.redAccent
                                                : const Color(0xFF1A1A1A),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: booked
                                              ? Colors.grey[700]!
                                              : selected
                                                  ? Colors.redAccent
                                                  : Colors.grey.withOpacity(0.4),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text('${col + 1}',
                                            style: TextStyle(
                                                color: booked ? Colors.grey[600] : Colors.white,
                                                fontSize: 10)),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ))),
                      const SizedBox(height: 16),

                      // Legend
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _legend(const Color(0xFF1A1A1A), 'Available'),
                          const SizedBox(width: 20),
                          _legend(Colors.redAccent, 'Selected'),
                          const SizedBox(width: 20),
                          _legend(Colors.grey.shade800, 'Booked'),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),

              // Bottom bar
              Container(
                padding: const EdgeInsets.all(20),
                color: const Color(0xFF1A1A1A),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_selectedSeats.length} seat${_selectedSeats.length != 1 ? 's' : ''} selected',
                          style: const TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        Text(
                          '\$${_total.toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: _confirmBooking,
                      icon: const Icon(Icons.confirmation_num, color: Colors.white),
                      label: const Text('Confirm Booking',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String t) => Text(t,
      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold));

  Widget _legend(Color color, String label) => Row(children: [
        Container(
          width: 16, height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.withOpacity(0.4)),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ]);
}
