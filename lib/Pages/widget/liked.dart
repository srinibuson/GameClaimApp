// widgets/like_button.dart
import 'package:Claimit_app/Service/firestore.dart';
import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final Map<String, dynamic> gameData;
  const LikeButton({required this.gameData, super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  final _service = FirestoreService();
  bool _isLiked = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkLiked();
  }

  Future<void> _checkLiked() async {
    final liked = await _service.isLiked(widget.gameData['id']);
    if (mounted)
      setState(() {
        _isLiked = liked;
        _loading = false;
      });
  }

  Future<void> _toggle() async {
    // Optimistic update — instant UI response
    setState(() => _isLiked = !_isLiked);

    final result = await _service.toggleLike(widget.gameData);

    // Sync with actual result
    if (mounted) setState(() => _isLiked = result);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Icon(Icons.favorite_border, color: Colors.white38, size: 28);
    }

    return GestureDetector(
      onTap: _toggle,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          _isLiked ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(_isLiked),
          color: _isLiked ? Colors.redAccent : Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
