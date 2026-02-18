# ☕ KivaLoop — Your Daily Coffee Companion

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Mapbox](https://img.shields.io/badge/Mapbox-000000?style=for-the-badge&logo=mapbox&logoColor=white)

> KivaLoop is not just an app — it's your daily coffee companion. Connect, explore, spin, and sip your way through a community built around the love of coffee.

---

## 📱 Screenshots

> _Add your screenshots here_

---

## ✨ Features

### 🔐 Authentication

- Sign in with **Email & Password**
- Sign in with **Google**
- Secure session management

### 🏠 Home Feed

- Browse coffee stories shared by the community
- View photos, thoughts, and favorite moments
- **React** and **comment** on posts
- Stay connected with coffee lovers around you

### 🎡 Fortune Wheel

- Spin the wheel **daily** for a chance to win points
- Collect and redeem points for **discounts and offers** at your favorite cafés
- Gamified rewards system to keep you coming back

### 🗺️ Coffee Shop Map

- Search for **nearby coffee shops** using Mapbox
- Explore new spots around your area
- Plan your next café visit with ease

### 👤 User Profiles

- View what others love to drink today
- Explore users' favorite cafés
- See earned and redeemed **reward points**

### 📝 Post Stories

- Share your coffee vibe with the community
- Upload photos and write about your coffee moments
- Build your presence in the KivaLoop circle

---

## 🛠️ Tech Stack

| Layer            | Technology         |
| ---------------- | ------------------ |
| Framework        | Flutter            |
| Language         | Dart               |
| Authentication   | Firebase Auth      |
| Database         | Firebase Firestore |
| Storage          | Firebase Storage   |
| Maps & Search    | Mapbox GL          |
| State Management | Provider           |
| Image Picker     | image_picker       |
| HTTP             | http               |

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x or above)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- A [Firebase](https://firebase.google.com/) project set up
- A [Mapbox](https://www.mapbox.com/) account and access token

---

### 🔧 Installation

**1. Clone the repository**

```bash
git clone https://github.com/Musta99/Kivaloop.git
cd Kivaloop
```

**2. Install dependencies**

```bash
flutter pub get
```

**3. Set up Firebase**

- Create a Firebase project at [console.firebase.google.com](https://console.firebase.google.com/)
- Add an Android and/or iOS app to your Firebase project
- Download `google-services.json` and place it in `android/app/`
- Run `flutterfire configure` if using FlutterFire CLI

**4. Set up Mapbox Token**

Add your Mapbox token to `android/local.properties` (this file is gitignored):

```
MAPBOX_TOKEN=your_mapbox_token_here
```

> ⚠️ **Never hardcode your Mapbox token directly in source files.** It is read securely from `local.properties` at build time.

**5. Run the app**

```bash
flutter run
```

---

## 📁 Project Structure

```
lib/
├── Features/
│   └── Screens/
│       ├── auth/               # Login & signup screens
│       ├── home/               # Home feed
│       ├── map_screen/         # Mapbox coffee shop map
│       ├── profile/            # User profiles
│       ├── fortune_wheel/      # Daily spin wheel
│       └── post/               # Create & view posts
├── State-Management/           # Provider state classes
│   └── AddPostState/
├── core/                       # Theme, constants, utilities
└── main.dart
```

---

## 🔐 Environment & Secrets

This project uses `local.properties` to keep secrets out of source control.

| Secret          | Location                                    |
| --------------- | ------------------------------------------- |
| Mapbox Token    | `android/local.properties` → `MAPBOX_TOKEN` |
| Firebase Config | `android/app/google-services.json`          |

Make sure these files are listed in `.gitignore`:

```
android/local.properties
google-services.json
```

---

## 📦 Key Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core:
  firebase_auth:
  cloud_firestore:
  firebase_storage:
  google_sign_in:
  provider:
  image_picker:
  http:
  flutter_easyloading:
  mapbox_maps_flutter:
  geolocator:
  flutter_easyloading:
  image_picker:
  http:
  uuid:
  flutter_screenutil:
  geocoding:
```

---

## 🤝 Contributing

Contributions are welcome! Here's how to get started:

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m 'Add your feature'`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Musta99**

- GitHub: [@Musta99](https://github.com/Musta99)

---

> _"Every sip leads to a new connection, a new place, or a new reward."_ ☕
