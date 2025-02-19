# 🎬 My Movie
Welcome to My Movie, a cross-platform mobile application built with Flutter to bring the latest movie information directly to your device. My Movie allows users to discover popular films, search for specific titles, and manage a personalized watchlist using data from TMDB (The Movie Database). Whether you’re an avid film enthusiast or a casual viewer, My Movie makes exploring cinema fun and easy!

## 🚀 Features
- __Discover Movies__: Browse trending and popular movies, complete with cast, crew, and plot summaries.
- __Search__: Find specific movies, genres, and actors effortlessly.
- __User Authentication__: Secure login and registration for a personalized experience.
- __Watchlist__: Save movies to a watchlist to track what you want to watch.
- __Personalized Recommendations__: Receive tailored recommendations based on your watchlist and viewing habits.
## 💼 Tech Stack
- __Programming Language__: Dart
- __Framework__: Flutter
- __Backend__: Supabase (for user authentication and data management)
- __APIs__: TMDB API for movie information
- __Additional Integrations__: OpenAI Vector Embedding for customized recommendations
- __Development Tools__: Visual Studio, Postman
## 🔍 Project Structure
This project follows Clean Architecture principles, ensuring that each layer is modular and maintains single responsibility:

- __Data Layer__: Manages data from TMDB and Supabase, leveraging `get_it` and `injectable` for efficient dependency injection.
- __Domain Layer__: Contains core business logic, use cases, and entities, creating a bridge between data and UI.
- __Presentation Layer__: Built using Flutter with BLoC for robust and reactive state management, ensuring smooth and responsive user interactions.
## 🎉 Getting Started

Follow these steps to set up and run My Movie on your device:

1. Clone the repository:
   ```bash
   git clone https://github.com/Hnquangg123/my_movie.git
2. Install dependencies:
   ```bash
   flutter pub get
3. Set up API keys for TMDB and Supabase in a `.env` file.
4. Run the app on an emulator or connected device
   ```bash
   flutter run
