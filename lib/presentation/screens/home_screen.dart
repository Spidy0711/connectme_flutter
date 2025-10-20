import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../widgets/user_card.dart';
import 'profile_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ConnectMe',
          style: TextStyle(fontFamily: 'Gotham'), // <-- Gotham applied
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(fontFamily: 'Gotham'),
              ),
            );
          } else if (state is UserLoaded) {
            // List of all countries
            final countries =
            state.users.map((u) => u.country).toSet().toList()..sort();

            // Filtered users
            final filteredUsers = selectedCountry == null
                ? state.users
                : state.users
                .where((u) => u.country == selectedCountry)
                .toList();

            final width = MediaQuery.of(context).size.width;
            final crossAxisCount = width < 600 ? 2 : 4;

            return Column(
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Profiles',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gotham', // <-- Gotham applied
                        ),
                      ),
                      DropdownButton<String>(
                        value: selectedCountry,
                        hint: const Text(
                          'Filter by country',
                          style: TextStyle(fontFamily: 'Gotham'),
                        ),
                        items: countries
                            .map<DropdownMenuItem<String>>(
                              (country) => DropdownMenuItem<String>(
                            value: country,
                            child: Text(
                              country,
                              style: const TextStyle(fontFamily: 'Gotham'),
                            ),
                          ),
                        )
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            selectedCountry = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<UserBloc>().add(LoadUsers());
                      setState(() => selectedCountry = null);
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(12),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        final actualIndex =
                        state.users.indexOf(user); // preserve liked index
                        final liked = state.likedUsers.contains(actualIndex);

                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<UserBloc>(),
                                child:
                                ProfileDetailsScreen(index: actualIndex),
                              ),
                            ),
                          ),
                          child: UserCard(
                              user: user, index: actualIndex, liked: liked),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
