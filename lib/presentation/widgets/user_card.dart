import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../../data/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final int index;
  final bool liked;

  const UserCard({
    super.key,
    required this.user,
    required this.index,
    required this.liked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // 🦋 Hero Transition for Image
            Hero(
              tag: 'user$index',
              child: Image.network(
                user.imageUrl,
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2));
                },
              ),
            ),

            // Gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black54,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.black38
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0, 0.3, 0.7, 1],
                ),
              ),
            ),

            // User info
            Positioned(
              left: 12,
              bottom: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.name}, ${user.age}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      shadows: [
                        Shadow(color: Colors.black45, blurRadius: 4)
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${user.city}, ${user.country}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      shadows: [
                        Shadow(color: Colors.black45, blurRadius: 3)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ❤️ Animated Like Button
            Positioned(
              bottom:8,
              top: 120,
              right: 0,
              left: 150,
              child: GestureDetector(
                onTap: () => context.read<UserBloc>().add(ToggleLike(index)),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) =>
                      ScaleTransition(scale: anim, child: child),
                  child: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    key: ValueKey(liked),
                    color: Colors.redAccent,
                    size: 28,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
