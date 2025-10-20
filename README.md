# ConnectMe Flutter App

A Flutter application to explore user profiles fetched from [RandomUser API](https://randomuser.me/api/).  
Built with **Bloc**, **Clean Architecture**, and **Responsive Design**.

## Features
- Display 20 user profiles in a grid layout
- View profile details with Hero image transition
- Like/unlike profiles with synchronized state across screens
- Filter profiles by country
- Pull-to-refresh
- Heart icon animation
- Responsive layout for multiple screen sizes
- Custom Gotham font

## Architecture
- **Data Layer:** Models and Repository
- **Domain Layer:** Entities
- **Presentation Layer:** Bloc, Screens, Widgets
- **State Management:** Bloc

## Installation
```bash
git clone https://github.com/yourusername/connectme_flutter.git
cd connectme_flutter
flutter pub get
flutter run
