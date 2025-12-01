# Biometric Secured Flutter To-Do App

A production-ready, fully responsive Flutter To-Do List application that enforces mandatory Biometric Authentication.

## Features

- **Biometric Security**: Uses Fingerprint/Face ID to secure access.
- **Clean Architecture**: Feature-first structure separating Domain, Data, and Presentation.
- **State Management**: Uses `flutter_bloc` (Cubit) with scoped instances.
- **Dependency Injection**: Uses `get_it` for efficient dependency management.
- **Navigation**: Uses `go_router` for declarative routing.
- **Animations**: Smooth list animations using `animated_list_plus`.
- **Task Management**:
    - **Edit**: Tap to edit task titles.
    - **Filter**: Switch between "All" (Active) and "Completed" tasks.
- **UI/UX**:
    - **Splash Screen**: Beautiful gradient splash screen with biometric icon.
    - **App Icon**: Custom designed biometric-themed launcher icon.
    - **Responsive Design**: Adapts to Phone and Tablet layouts.
- **Persistence**: Tasks are saved locally using `shared_preferences`.

## Architecture

The project follows a **Feature-based Clean Architecture**:

- **Domain Layer**: Pure Dart code defining Entities and Repository Interfaces.
- **Data Layer**: Handles data retrieval (Local Auth, Shared Prefs) and Model serialization.
- **Presentation Layer**: UI Components and Cubits for state management.

## Setup

1.  **Dependencies**:
    Run `flutter pub get` to install dependencies.

2.  **Biometrics**:
    - **Android**: Ensure your emulator/device has a Screen Lock (PIN/Pattern) and enrolled Fingerprint.
    - **iOS**: Ensure FaceID/TouchID is enrolled in Simulator features.

3.  **Run**:
    `flutter run`

## Color Palette

- Primary Dark: #03045E
- Primary Accent: #0077B6
- Secondary Accent: #00B4D8
- Background Light: #90E0EF
