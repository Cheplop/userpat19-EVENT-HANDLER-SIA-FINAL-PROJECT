# EventFlow - Frontend

A vibrant and accessible Flutter application for managing events. Users can log in as guests or admins to browse, view, and manage upcoming events with an intuitive, energetic UI.

## Features

- **Login System**: Choose between admin or user login to access different functionalities.
- **Event Browsing**: View a list of upcoming events with key details like date, location, and capacity.
- **Event Details**: Tap on any event to see full details, including description and formatted date/time.
- **Admin Features**:
  - Create new events with title, location, description, date/time, and capacity.
  - Edit existing events.
  - Delete events with confirmation.
- **Logout**: Easily log out and return to the login screen.
- **Accessible Design**: Clean layouts, high contrast, and user-friendly navigation for great UX.

## Getting Started

### Prerequisites

- Flutter SDK installed ([Install Flutter](https://flutter.dev/docs/get-started/install))
- A compatible IDE (e.g., VS Code with Flutter extension)

### Running the App

1. Clone the repository and navigate to the `frontend` directory:
   ```
   cd frontend
   ```

2. Install dependencies:
   ```
   flutter pub get
   ```

3. Run the app on a connected device or emulator:
   ```
   flutter run
   ```

For help with Flutter development, check the [official documentation](https://docs.flutter.dev/).

## Project Structure

- `lib/main.dart`: App entry point with theme configuration.
- `lib/screens/`: Contains all UI screens (login, event list, details, form).
- `lib/models/`: Data models (e.g., Event).
- `lib/data/`: In-memory data repository for events.

## Contributing

Feel free to contribute by opening issues or pull requests. Ensure code follows Flutter best practices and passes `flutter analyze`.
