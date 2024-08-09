# PARTH_PARKING - Parking Management App

![SwiftUI](https://img.shields.io/badge/SwiftUI-2.0-orange) ![Firebase](https://img.shields.io/badge/Firebase-9.0-yellow) ![iOS](https://img.shields.io/badge/iOS-14.0-blue)

## 📋 Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
  - [Using CocoaPods](#using-cocoapods)
  - [Using Swift Package Manager (SPM)](#using-swift-package-manager-spm)
- [Running the App](#running-the-app)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## 🚀 Introduction

**SwiftParking** is an iOS application developed using **SwiftUI** and **Firebase**. This application allows users to manage their parking records with features such as adding, viewing, editing, and deleting parking records. The app integrates Firebase Authentication for secure user management and Firestore for data persistence.

## 🌟 Features

- **User Authentication**: Secure user sign-up, login, profile update, and account deletion using Firebase Authentication.
- **Add Parking**: Create new parking records with detailed information including location, time, and car details.
- **View Parking Records**: View a list of all parking records sorted by the most recent entries.
- **Edit and Delete Parking**: Modify parking details or delete records as needed.
- **Profile Management**: Update user profile information including name, contact number, and car plate numbers.
- **Location Services**: Integrate geocoding and reverse geocoding to manage parking locations.

## 🛠️ Prerequisites

Before you begin, ensure you have the following installed:

- **Xcode**: Version 12 or later
- **iOS Device or Simulator**: Running iOS 14 or later
- **CocoaPods**: For managing Firebase dependencies (if using this method)
- **Swift Package Manager (SPM)**: Integrated within Xcode

## 🔧 Installation

### Using CocoaPods

1. **Install CocoaPods** (if not already installed):

```bash
sudo gem install cocoapods
```

Clone the Repository:

```bash
git clone https://github.com/htrap5283/parking-managment-iOS-app.git
cd parking-managment-iOS-app
```

Install Dependencies:

```bash
pod install
```

This will install all necessary dependencies, including Firebase.

Open the Workspace:
Open the .xcworkspace file in Xcode.

Using Swift Package Manager (SPM)

Open Your Project in Xcode:

Go to File > Swift Packages > Add Package Dependency....

Enter the Firebase GitHub Repository URL:

```bash
https://github.com/firebase/firebase-ios-sdk.git
```

Choose Dependencies:

Select the Firebase libraries you need, such as FirebaseAuth and FirebaseFirestore.

Integrate Firebase:

Follow the setup instructions for Firebase, including downloading the GoogleService-Info.plist file and adding it to your project.

Configure Firebase:

Follow the setup instructions for Firebase, including downloading the GoogleService-Info.plist file and adding it to your project.

## Running the App 🏃

Open the .xcworkspace file in Xcode (if using CocoaPods) or the .xcodeproj file if using SPM or Carthage.
Select your target device or simulator.
Build and run the project using the play button in Xcode.

## Project Structure 📁

Here's a brief overview of the project's file structure:

```
parking-managment-iOS-app
├── project.xcodeproj             # Xcode project files
├── project.xcworkspace           # Xcode workspace for CocoaPods
├── GoogleService-Info.plist      # Firebase configuration file
├── Models                        # Data models
│   ├── Parking.swift
│   ├── User.swift
├── Views                         # SwiftUI views
│   ├── ContentView.swift
│   ├── HomeView.swift
│   ├── NewParkingView.swift
│   ├── ParkingDetailView.swift
│   ├── ParkingMapView.swift
│   ├── ProfileView.swift
│   ├── SignInView.swift
│   ├── SignUpView.swift
│   ├── UpdateParkingView.swift
│   └── UpdateProfileView.swift
├── Controllers                   # ViewModels for managing state
│   ├── FireAuthHelper.swift
│   └── FireDBHelper.swift
└── PARTH_PARKINGApp.swift        # Main entry point
```

## 🧑‍💻 Usage

### Sign-In

- Open the app and enter your email and password to access the main dashboard.
- If you don't have an account, click on "Sign Up" to create a new account.
- Enable the "Remember Me" checkbox to save your credentials for future logins.

### Add Parking

- From the Home screen, tap on the "Add Parking" button.
- Fill in the required fields:
  - **Building Code**: Enter a 5-character alphanumeric building code.
  - **Hours**: Select the intended parking duration (1-hour, 4-hour, 12-hour, 24-hour).
  - **License Plate**: Enter your car's license plate number (2-8 characters).
  - **Host Suite**: Enter the host suite number (2-5 characters).
  - **Street Name**: Enter the street name manually or use your current location to auto-fill the address.
- Tap "Add Parking" to save the record.

### View Parking Records

- View your saved parking records from the Home screen.
- Records are displayed with the most recent entries first.
- Tap on any parking record to view its detailed information, including the location on a map.

### Edit Parking

- From the Home screen, tap on a parking record to view its details.
- Click on "Update Parking" to modify the record.
- Change any field except the date and time of parking.
- Save the changes to update the record in the database.

### Delete Parking

- From the Home screen, swipe left on any parking record to reveal the delete option.
- Confirm deletion to remove the record from your list.

### Profile Management

- Access your profile by tapping the "Profile" button in the toolbar.
- View your current profile information, including your name, email, contact number, and car plates.
- To update your profile, click on "Update" and make the necessary changes.
- Save your changes to update your profile in the database.
- You can also log out or delete your account from this screen.

### Location and Map

- When viewing a parking record, tap on the map to view the parking location.
- The map will show the precise location of your parking with a pin.

### Sharing

- From the Session Details screen, tap the "Share" button to open the iOS share sheet.
- Share session details with others through your preferred communication apps (e.g., Messages, WhatsApp, Email).

🤝 Contributing
Contributions are always welcome! Here are some ways you can help:

Reporting Bugs: Use the issue tracker to report bugs.
Suggesting Enhancements: Propose improvements or new features.
Pull Requests: Fork the repository and submit pull requests.
Pull Request Process
Fork the repository.
Create a new branch (git checkout -b feature/YourFeatureName).
Make your changes and commit (git commit -m 'Add some feature').
Push to the branch (git push origin feature/YourFeatureName).
Open a pull request.
Please ensure your code follows the project's coding style and includes relevant documentation.

📜 License
This project is licensed under the MIT License - see the LICENSE file for details.

📬 Contact
If you have any questions or feedback, feel free to reach out:

Email: parthjp5283@gmail.com
GitHub: htrap5283
