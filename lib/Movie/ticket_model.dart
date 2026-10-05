import 'movie_model.dart';

class Ticket {
  final Movie movie;
  final String date;
  final String time;
  final List<String> seats;
  final double totalPrice;
  final DateTime bookedAt;

  Ticket({
    required this.movie,
    required this.date,
    required this.time,
    required this.seats,
    required this.totalPrice,
    required this.bookedAt,
  });
}

List<Ticket> myTickets = [];

const double ticketPrice = 12.99;
