ConnectMe Flutter App

A student-friendly Flutter app to explore user profiles fetched from RandomUser API.
Built with Bloc, Clean Architecture, and Responsive Design.

# Features

1. Fetch and display 20 random user profiles in a grid layout
2. Tap a profile to view details with Hero image transition
3. Like/unlike profiles – state stays synced between Home and Profile screens
4. Filter profiles by country
5. Pull-to-refresh for updated profiles
6. Heart icon animation for likes
7.Custom Gotham font applied across the app
8.Loading & error states handled gracefully

# Architecture

1. Data Layer: Models (UserModel) and Repository (UserRepository)
2. Domain Layer: Entities (UserEntity)
3. Presentation Layer: Bloc, Screens, Widgets
4. State Management: Bloc (flutter_bloc)

Bloc Events:

1. LoadUsers() – Fetch users from API
2. ToggleLike(index) – Toggle like/unlike
   
Bloc States:

1. UserLoading – Shows a loading indicator
2. UserLoaded – Contains user list & liked set
3. UserError – Displays error message

# Tech Stack

1. Flutter: 3.32.6
2. State Management: flutter_bloc ^9.1.1
3. HTTP Requests: http ^1.5.0
4. Network Images: cached_network_image ^3.4.1
5. Equatable: ^2.0.7 (for Bloc state comparison)

Fonts/UI: Custom Gotham font

# Project Structure

screenshots/
├── home_screen.jpg
├── profile_screen.jpg
├── filtered_profile.jpg
└── country_filter.jpg

lib/
├── assets/
│   └── fonts/
│       └── bold.otf                # Gotham font
│
├── data/
│   ├── models/                     # UserModel
│   └── repositories/               # UserRepository
│
├── domain/
│   └── entities/                   # UserEntity
│
├── presentation/
│   ├── bloc/                       # UserBloc, UserEvent, UserState
│   ├── screens/                    # HomeScreen, ProfileDetailsScreen
│   └── widgets/                    # UserCard
│
└── main.dart

# Installation

git clone https://github.com/yourusername/connectme_flutter.git
cd connectme_flutter
flutter pub get
flutter run

# Known Issues

1. Requires internet; offline caching not implemented yet
2. Pull-to-refresh resets selected country filter

# LICENSE

This project is licensed under the MIT License. See the LICENSE file for details.

# Contact

Atharva Patil – atharvadp31@gmail.com
