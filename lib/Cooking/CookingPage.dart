import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;

// Store your API key in a .env file or pass via --dart-define=GEMINI_API_KEY=your_key
const String _apiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
const String _apiUrl = 'http://localhost:3000/gemini';

class CookingPage extends StatefulWidget {
  const CookingPage({super.key});

  @override
  State<CookingPage> createState() => _CookingPageState();
}

class _CookingPageState extends State<CookingPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isLoading = true;
    });
    _controller.clear();
    _scrollToBottom();

    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'system_instruction': {
            'parts': [
              {
                'text':
                    'You are a professional chef and cooking assistant. Help users with recipes, cooking tips, ingredient substitutions, meal planning, and any cooking-related questions. Format recipes clearly with ingredients and steps.'
              }
            ]
          },
          'contents': [
            {
              'parts': [
                {'text': text}
              ]
            }
          ]
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final candidates = data['candidates'];
        if (candidates != null && candidates.isNotEmpty) {
          final reply = candidates[0]['content']['parts'][0]['text'];
          setState(() {
            _messages.add({'role': 'ai', 'text': reply ?? 'No response.'});
          });
        } else {
          setState(() {
            _messages.add({'role': 'ai', 'text': 'No response from AI. Raw: ${response.body}'});
          });
        }
      } else {
        setState(() {
          _messages.add({'role': 'ai', 'text': 'Error ${response.statusCode}: ${response.body}'});
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({'role': 'ai', 'text': 'Error: $e'});
      });
    } finally {
      setState(() => _isLoading = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Color(0xFF16213E),
        title: Row(
          children: [
            Icon(Icons.restaurant, color: Colors.orangeAccent),
            SizedBox(width: 10),
            Text('AI Cooking Assistant',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: _messages.isEmpty
                    ? _buildWelcome()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(16),
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          return _buildMessage(msg['role']!, msg['text']!);
                        },
                      ),
              ),
              if (_isLoading)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.orangeAccent)),
                      SizedBox(width: 10),
                      Text('Chef AI is thinking...',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              Container(
                padding: EdgeInsets.all(12),
                color: Color(0xFF16213E),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Colors.white),
                        onSubmitted: (_) => _sendMessage(),
                        decoration: InputDecoration(
                          hintText: 'Ask me anything about cooking...',
                          hintStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Color(0xFF0F3460),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    CircleAvatar(
                      backgroundColor: Colors.orangeAccent,
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
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

  Widget _buildWelcome() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant_menu, size: 80, color: Colors.orangeAccent),
          SizedBox(height: 20),
          Text('Welcome to AI Cooking Assistant!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Ask me for recipes, cooking tips, or meal ideas.',
              style: TextStyle(color: Colors.grey, fontSize: 15)),
          SizedBox(height: 30),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _suggestionChip('🍝 Pasta recipe'),
              _suggestionChip('🥗 Healthy salad ideas'),
              _suggestionChip('🍰 Easy desserts'),
              _suggestionChip('🔪 Knife skills tips'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _suggestionChip(String label) {
    return ActionChip(
      label: Text(label, style: TextStyle(color: Colors.white)),
      backgroundColor: Color(0xFF0F3460),
      onPressed: () {
        _controller.text = label.substring(2).trim();
        _sendMessage();
      },
    );
  }

  Widget _buildMessage(String role, String text) {
    final isUser = role == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        padding: EdgeInsets.all(14),
        constraints: BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          color: isUser ? Colors.orangeAccent : Color(0xFF16213E),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isUser ? Radius.circular(16) : Radius.zero,
            bottomRight: isUser ? Radius.zero : Radius.circular(16),
          ),
        ),
        child: isUser
            ? Text(text, style: TextStyle(color: Colors.white))
            : MarkdownBody(
                data: text,
                styleSheet: MarkdownStyleSheet(
                  p: TextStyle(color: Colors.white, fontSize: 14),
                  strong: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.bold),
                  h2: TextStyle(
                      color: Colors.orangeAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  listBullet: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }
}
