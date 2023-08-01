# Cine4u
![Flutter](https://img.shields.io/badge/-Flutter-02569B?style=flat-square&logo=flutter)
![Dart](https://img.shields.io/badge/-Dart-0175C2?style=flat-square&logo=dart)
![Firebase](https://img.shields.io/badge/-Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)

Cine4u is a Progressive Web App (PWA) developed using [Flutter](https://flutter.dev/), written in [Dart](https://dart.dev/). The app interfaces with [The Movie Database (TMDB) API](https://www.themoviedb.org/documentation/api) for fetching and displaying movie-related information, and leverages [Firebase](https://firebase.google.com/) for backend services such as user authentication, database management, and hosting. The application offers an engaging and interactive movie database, accessible on a variety of platforms.

## Getting Started

You first need flutter to be installed on your machine.

To install the packages needed, run:
```bash
flutter pub get
```

If "Chrome (web)" or "Edge (web)" doesn't appear in your list of devices, 
you need to enable web support. You can do this by enabling web support:
```bash
flutter config --enable-web
```

This command will run the App locally in a development version of Chrome.
Replace 'chrome' with 'edge' to run the app in Edge.
```bash
flutter run -d chrome
```

Although not really necessary, you can generate the web pages with:
```bash
flutter build web
```

## Firebase Initialization

If you want to host this application, you'll need to initialize Firebase. Here's how:

Install Firebase CLI on your machine via npm:
```bash
npm install -g firebase-tools
```

Authenticate Firebase CLI with your Google account:
```bash
firebase login
```

Initialize your Firebase project:
```bash
firebase init
```

*Follow the CLI prompts to connect your local project with your Firebase account.*

Finally, to deploy your application:
```bash
firebase deploy
```

## Demo Images

*Movies Page with Search mechanism*
![Movies Page with Search mechanism...](https://github.com/Avion9/Cine4us/blob/main/assets/Demo/Demo_All_Movies.PNG?raw=true)
*Movie Detail Page*
![Movie Detail Page...](https://github.com/Avion9/Cine4us/blob/main/assets/Demo/Demo_Detail.PNG?raw=true)
*Trailer Video Player Layout*
![Watching Trailer Layout...](https://github.com/Avion9/Cine4us/blob/main/assets/Demo/Demo_Trailer.PNG?raw=true)

