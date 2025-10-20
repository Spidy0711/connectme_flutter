import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';

class ProfileDetailsScreen extends StatelessWidget {
  final int index;
  const ProfileDetailsScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            final user = state.users[index];
            final liked = state.likedUsers.contains(index);

            return Stack(
              children: [
                // Full screen user image
                Positioned.fill(
                  child: Hero(
                    tag: 'user$index',
                    child: Image.network(
                      user.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 🔹 Top bar with back and menu icons
                Positioned(
                  top: MediaQuery.of(context).padding.top + 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back arrow
                      CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      // 3-dot/hamburger menu
                      CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.4),
                        child: IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.white),
                          onPressed: () {
                            // Menu action
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => const SafeArea(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    "Menu options go here",
                                    style: TextStyle(fontFamily: 'Gotham'),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom white info card
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name + Age
                          Text(
                            '${user.name}, ${user.age}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontFamily: 'Gotham', // <-- Gotham applied
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Location title + info + heart icon
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Location",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontFamily: 'Gotham', // <-- Gotham applied
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${user.city}, ${user.country ?? 'India'}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                      fontFamily: 'Gotham', // <-- Gotham applied
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(
                                  liked ? Icons.favorite : Icons.favorite_border,
                                  color: liked ? Colors.red : Colors.black,
                                ),
                                onPressed: () =>
                                    context.read<UserBloc>().add(ToggleLike(index)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
