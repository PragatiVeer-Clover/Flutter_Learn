import 'dart:ui_web' as ui;
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

// Same dummy trailer for all movies (Big Buck Bunny - free & public domain)
const _videoId = 'aqz-KE-bpKQ';

class VideoPlayerPage extends StatefulWidget {
  final String movieTitle;
  const VideoPlayerPage({super.key, required this.movieTitle});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final String _viewId = 'yt-player-${DateTime.now().millisecondsSinceEpoch}';

  @override
  void initState() {
    super.initState();
    ui.platformViewRegistry.registerViewFactory(_viewId, (int id) {
      final iframe = web.document.createElement('iframe') as web.HTMLIFrameElement;
      iframe.src = 'https://www.youtube.com/embed/$_videoId?autoplay=1&controls=1&rel=0';
      iframe.style.border = 'none';
      iframe.style.width = '100%';
      iframe.style.height = '100%';
      iframe.allow = 'autoplay; fullscreen';
      return iframe;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.movieTitle,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            const Text('Now Playing', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 960),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Video player
              AspectRatio(
                aspectRatio: 16 / 9,
                child: HtmlElementView(viewType: _viewId),
              ),
              const SizedBox(height: 24),

              // Movie title card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.movie, color: Colors.redAccent, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.movieTitle,
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          const Text('Official Trailer',
                              style: TextStyle(color: Colors.grey, fontSize: 13)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.redAccent.withOpacity(0.4)),
                      ),
                      child: const Text('HD', style: TextStyle(color: Colors.redAccent, fontSize: 12)),
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
}
