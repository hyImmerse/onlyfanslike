# Firebase Setup Guide

This guide will help you set up Firebase for the Creator Platform Demo app.

## Prerequisites

1. A Google account
2. Flutter development environment set up
3. This project cloned and dependencies installed

## Step 1: Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter a project name (e.g., "creator-platform-demo")
4. Follow the setup wizard (you can disable Google Analytics if not needed)

## Step 2: Add Firebase to your Flutter app

### For Web:

1. In Firebase Console, click the Web icon (</>) to add a web app
2. Register your app with a nickname (e.g., "Creator Platform Web")
3. Copy the Firebase configuration object

### For Android:

1. Click "Add app" and select Android
2. Enter your Android package name: `com.example.creator_platform_demo`
3. Download the `google-services.json` file
4. Place it in `android/app/` directory

### For iOS:

1. Click "Add app" and select iOS
2. Enter your iOS bundle ID: `com.example.creatorPlatformDemo`
3. Download the `GoogleService-Info.plist` file
4. Open the iOS project in Xcode and add the file to the Runner folder

## Step 3: Update Firebase Configuration

1. Open `lib/main.dart`
2. Replace the placeholder Firebase configuration with your actual config:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "your-actual-api-key",
    authDomain: "your-project.firebaseapp.com",
    projectId: "your-project-id",
    storageBucket: "your-project.appspot.com",
    messagingSenderId: "your-sender-id",
    appId: "your-app-id",
    measurementId: "your-measurement-id", // Optional
  ),
);
```

## Step 4: Set up Firestore Database

1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" for development (remember to set up security rules later)
4. Select your preferred location

## Step 5: Initialize Firestore Collections

The app will automatically create collections as needed, but you can manually create these collections:

- `contents` - Stores all content items
- `creators` - Stores creator profiles
- `users` - Stores user profiles
- `subscriptions` - Stores subscription data

## Step 6: Security Rules (Important!)

For production, update your Firestore security rules. Here's a basic example:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow read access to public content
    match /contents/{document} {
      allow read: if resource.data.isPublic == true;
      allow read, write: if request.auth != null && request.auth.uid == resource.data.creatorId;
      allow create: if request.auth != null;
    }
    
    // Allow users to read and write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Add more rules as needed
  }
}
```

## Step 7: 패키지 설치 및 설정 완료

1. **Flutter 패키지 설치**:
   ```bash
   flutter pub get
   ```

2. **Firebase 관련 코드 주석 해제**:
   - `lib/main.dart`: Firebase 초기화 코드 주석 해제
   - `lib/presentation/providers/repository_providers.dart`: Firebase import 및 사용 주석 해제

3. **앱 실행**:
   ```bash
   flutter run
   ```

4. 앱이 이제 Mock 데이터 대신 Firebase에 연결됩니다.

## Step 8: 현재 상태 (임시 Mock 사용 중)

⚠️ **현재는 Firebase 패키지 의존성 문제로 인해 임시로 Mock 데이터를 사용하고 있습니다.**

Firebase를 활성화하려면:
1. 터미널에서 `flutter pub get` 실행
2. `lib/main.dart`에서 Firebase 초기화 코드 주석 해제
3. `lib/presentation/providers/repository_providers.dart`에서 FirebaseContentRepository 사용으로 변경

## Troubleshooting

### Common Issues:

1. **Platform-specific setup**: Make sure you've completed platform-specific setup for Android/iOS
2. **API Keys**: Ensure all API keys are correctly copied
3. **Network permissions**: Check that your app has internet permissions
4. **Firebase initialization**: Ensure Firebase is initialized before any Firebase service is used

### Switching between Mock and Firebase

To switch back to mock data, edit `lib/presentation/providers/repository_providers.dart`:

```dart
final contentRepositoryProvider = Provider<ContentRepository>((ref) {
  // return FirebaseContentRepository(); // Comment this line
  return MockContentRepository(); // Uncomment this line
});
```

## Next Steps

1. Implement Firebase Authentication
2. Add Firebase Storage for media uploads
3. Set up proper security rules
4. Implement the remaining Firebase repositories (User, Creator, Subscription)
5. Add error handling and offline support

## Resources

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)