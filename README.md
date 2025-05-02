Fall News
Overview
Fall News is a personalized news reader app built with Flutter, delivering curated headlines and stories in a clean, user-friendly interface. Using the News API, the app provides users with the latest news articles from global sources. Key features include browsing news, viewing detailed articles, bookmarking stories, and synchronizing bookmarks across devices with Firebase authentication. The app supports offline caching for seamless usability.
Features

News List: Displays a list of news articles with headlines, images, and summaries in a user-friendly list view.
Article Details: Shows full article details including headline, image, text, author, date, and source when an article is selected.
Bookmarking: Enables users to bookmark articles for later reading with a dedicated button in the article details view.
User Authentication: Implements sign-in and sign-up functionality using Firebase Authentication.
Bookmark Synchronization: Syncs bookmarked articles across devices when the user logs in with the same account.
Offline Support: Provides offline caching to ensure usability when the device is not connected to the internet.

Evaluation Criteria
This project adheres to the following best practices as recommended by CodersBucket:

Structure: Organized file structure following Clean Architecture principles.
Architecture: Implements Clean Architecture with separation of concerns (UI, BLoC, Repository, Data Models).
Performance: Optimized with offline caching (Firestore, Hive) and efficient state management.
Code Quality: Maintainable, readable code with dependency injection and proper error handling.

Technologies and Libraries

Flutter: Cross-platform framework for building the app.
Firebase:
firebase_core: ^3.13.0: Core Firebase services.
firebase_auth: ^5.5.2: Authentication system.
cloud_firestore: ^5.6.6: Database for bookmarks and sync.


flutter_bloc: ^9.1.0: State management using the BLoC pattern.
get_it: ^8.0.3: Dependency injection for modular code.
equatable: ^2.0.7: Simplifies state comparison in BLoC.
either_dart: ^1.0.0: Functional programming for error handling.
dio: ^5.8.0+1: HTTP client for News API requests.
flutter_dotenv: ^5.2.1: Environment variable management.
hive: ^2.2.3 & hive_flutter: ^1.1.0: Local storage for offline caching.
flutter_screenutil: ^5.9.3: Responsive UI scaling.
shimmer: ^3.0.0: Loading placeholders for better UX.
cached_network_image: ^3.4.1: Efficient image caching.
flutter_svg: ^2.1.0: SVG support for icons.
intl: ^0.20.2: Date formatting.
internet_connection_checker_plus: ^2.7.1: Connectivity monitoring.
uuid: ^3.0.7: Unique ID generation for bookmarks.

Installation

Clone the repository:git clone https://github.com/hredhayxz/fallnews-flutter.git


Navigate to the project directory:cd fall-news


Install dependencies:flutter pub get


Set up Firebase:
Create a Firebase project at Firebase Console.
Add an Android/iOS app to your Firebase project.
Download google-services.json (Android) or GoogleService-Info.plist (iOS) and place it in the respective directories.
Run:flutterfire configure




Configure News API:
Create a .env file in the root directory.
Add your News API key:NEWS_API_KEY=your_news_api_key_here




Run the app:flutter run



Usage

Sign In/Sign Up: Use the authentication screen to log in or create an account.
Browse News: View the list of news articles on the home screen.
View Details: Tap an article to see full details.
Bookmark Articles: Tap the bookmark icon in the details screen to save an article.
Access Bookmarks: Navigate to the bookmarks screen to view saved articles.

Screenshots



News List Screen
Article Details Screen
Bookmark Screen
Auth Screen
Offline Mode



APK
Download the latest APK here.

Project Structure
lib/
├── core/              # Core utilities, constants, and DI
├── data/              # Data models and repositories
├── presentation/      # UI and BLoC logic
└── main.dart          # App entry point

Contributing
Feel free to fork this repository and submit pull requests. For major changes, please open an issue first to discuss.
License
This project is licensed under the MIT License - see the LICENSE.md file for details.


Thanks to NewsAPI for providing the news data.

