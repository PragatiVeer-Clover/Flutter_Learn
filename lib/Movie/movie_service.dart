import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie_model.dart';

const _apiKey = '4a2a6e9a7d4e4b3c8f1e2d5c6b7a8f9e';
const _base = 'https://api.themoviedb.org/3';

class MovieService {
  static Future<List<Movie>> fetchTrending() => _fetch('/trending/movie/week');
  static Future<List<Movie>> fetchPopular() => _fetch('/movie/popular');
  static Future<List<Movie>> fetchTopRated() => _fetch('/movie/top_rated');
  static Future<List<Movie>> fetchUpcoming() => _fetch('/movie/upcoming');
  static Future<List<Movie>> search(String query) =>
      _fetch('/search/movie', extra: '&query=${Uri.encodeComponent(query)}');

  static Future<List<Movie>> _fetch(String path, {String extra = ''}) async {
    final url = '$_base$path?api_key=$_apiKey&language=en-US&page=1$extra';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return (data['results'] as List).map((e) => Movie.fromJson(e)).toList();
    }
    return _dummyMovies();
  }

  static List<Movie> _dummyMovies() => [
    Movie(
      id: 27205, title: 'Inception',
      overview: 'A thief who steals corporate secrets through dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
      posterPath: '/oYuLEt3zVCKq57qu2F8dT7NIa6f.jpg',
      backdropPath: '/s3TBrRGB1iav7gFOCNx3H31MoES.jpg',
      rating: 8.8, releaseDate: '2010-07-16', genreIds: [28, 878, 53],
    ),
    Movie(
      id: 155, title: 'The Dark Knight',
      overview: 'Batman raises the stakes in his war on crime. With the help of Lt. Jim Gordon and DA Harvey Dent, Batman sets out to dismantle the remaining criminal organizations.',
      posterPath: '/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
      backdropPath: '/hqkIcbrOHL86UncnHIsHVcVmzue.jpg',
      rating: 9.0, releaseDate: '2008-07-18', genreIds: [28, 80, 18],
    ),
    Movie(
      id: 157336, title: 'Interstellar',
      overview: 'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
      posterPath: '/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
      backdropPath: '/xJHokMbljvjADYdit5fK5VQsXEG.jpg',
      rating: 8.6, releaseDate: '2014-11-07', genreIds: [12, 18, 878],
    ),
    Movie(
      id: 299534, title: 'Avengers: Endgame',
      overview: 'After the devastating events of Infinity War, the Avengers assemble once more to reverse Thanos actions and restore balance to the universe.',
      posterPath: '/or06FN3Dka5tukK1e9sl16pB3iy.jpg',
      backdropPath: '/7RyHsO4yDXtBv1zUU3mTpHeQ0d5.jpg',
      rating: 8.4, releaseDate: '2019-04-26', genreIds: [28, 12, 878],
    ),
    Movie(
      id: 603, title: 'The Matrix',
      overview: 'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',
      posterPath: '/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
      backdropPath: '/fNG7i7RqMErkcqhohV2a6cV1Ehy.jpg',
      rating: 8.7, releaseDate: '1999-03-31', genreIds: [28, 878],
    ),
    Movie(
      id: 496243, title: 'Parasite',
      overview: 'A poor family schemes to become employed by a wealthy family and infiltrate their household by posing as unrelated, highly qualified individuals.',
      posterPath: '/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
      backdropPath: '/TU9NIjwzjoKPwQHoHshkFcQUCG.jpg',
      rating: 8.5, releaseDate: '2019-05-30', genreIds: [35, 18, 53],
    ),
    Movie(
      id: 238, title: 'The Godfather',
      overview: 'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.',
      posterPath: '/3bhkrj58Vtu7enYsLeMLoNWsgfb.jpg',
      backdropPath: '/tmU7GeKVybMWFButWEGl2M4GeiP.jpg',
      rating: 9.2, releaseDate: '1972-03-14', genreIds: [18, 80],
    ),
    Movie(
      id: 680, title: 'Pulp Fiction',
      overview: 'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.',
      posterPath: '/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
      backdropPath: '/suaEOtk1N1sgg2MTM7oZd2cfVp3.jpg',
      rating: 8.9, releaseDate: '1994-09-10', genreIds: [53, 80],
    ),
    Movie(
      id: 13, title: 'Forrest Gump',
      overview: 'The presidencies of Kennedy and Johnson, the Vietnam War and other historical events unfold from the perspective of an Alabama man with an extraordinary life.',
      posterPath: '/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
      backdropPath: '/qdIMHd4sEfJSckfVJfKQvisL02a.jpg',
      rating: 8.8, releaseDate: '1994-07-06', genreIds: [35, 18, 10749],
    ),
    Movie(
      id: 11, title: 'Star Wars',
      overview: 'Luke Skywalker joins forces with a Jedi Knight, a cocky pilot, a Wookiee and two droids to save the galaxy from the Empire\'s world-destroying battle station.',
      posterPath: '/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg',
      backdropPath: '/zqkmTXzjkAgXmEWLRsY4UpTWCeo.jpg',
      rating: 8.6, releaseDate: '1977-05-25', genreIds: [12, 28, 878],
    ),
    Movie(
      id: 424, title: 'Schindler\'s List',
      overview: 'In German-occupied Poland during World War II, industrialist Oskar Schindler gradually becomes concerned for his Jewish workforce after witnessing their persecution.',
      posterPath: '/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg',
      backdropPath: '/loRmRzQXZeqG78TqZuyvSlEQfZb.jpg',
      rating: 9.0, releaseDate: '1993-12-15', genreIds: [18, 36, 10752],
    ),
    Movie(
      id: 389, title: '12 Angry Men',
      overview: 'A jury holdout attempts to prevent a miscarriage of justice by forcing his colleagues to reconsider the evidence.',
      posterPath: '/ppd84D2i9W8jXmsyInGyihiSyqz.jpg',
      backdropPath: '/qqHQsStV6exghCM7zbObuYBiYxw.jpg',
      rating: 9.0, releaseDate: '1957-04-10', genreIds: [18],
    ),
  ];
}
