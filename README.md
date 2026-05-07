# Legal AI Consultation

# ⚖️ Flutter Legal AI App (Feature-First Architecture)

A modern, intuitive application built with **Flutter**. This project integrates a **Retrieval-Augmented Generation (RAG)** system to provide reliable, source-backed legal consultations. It demonstrates a **Feature-First Architecture** emphasizing scalability, modularity, and maintainability.

## ✨ Features

* **Legal AI Assistant**: Get instant, accurate answers to legal queries powered by an advanced RAG model.
* **Smart User Experience**:
    * 💬 **Interactive Chat**: A seamless chat interface for asking questions and receiving legal advice.
    * 👤 **Personalization**: Manage user profiles, settings, and consultation history.
    * 🔒 **Secure Authentication**: Robust authentication flow including Google Sign-in and standard email verification.
* **Modern UI**: Custom built components following Material Design guidelines with smooth transitions.
* **Theme Support**: Adaptive layouts and color schemes.

## 🛠️ Tech Stack & Architecture

This project is built using a **Feature-First Architecture** to effectively separate concerns into independent, highly cohesive modules:

* **💬 Consultation**: Chat interfaces, AI integration, and query handling.
* **🔐 Authentication**: Secure user login, registration, and session management.
* **👤 Personalization**: Profile management and user preferences.
* **⚙️ Core Utilities**: Shared constants, network configurations, and localizations.

### Key Packages
* **State Management & Routing**: `get` (GetX)
* **Backend Services**: `firebase_core`, `cloud_firestore`
* **Authentication**: `firebase_auth`, `google_sign_in`
* **Network / APIs**: `http`
* **Local Storage**: `shared_preferences`

## 📂 Project Structure

```text
lib/
├── data/               # DATA LAYER
│   ├── repositories/   # Abstracted API & Database access
│   └── services/       # Core background services
├── features/           # FEATURE MODULES (UI & Logic combined)
│   ├── authentication/ # Auth-related components
│   │   ├── controllers/# GetX state controllers
│   │   ├── models/     # Data models
│   │   └── screens/    # Login, signup views
│   ├── consultation/   # AI Chat/Consultation interfaces
│   │   ├── controllers/# GetX state controllers
│   │   ├── models/     # Data models
│   │   └── screens/    # Chat screens, history views
│   └── personalization/# User Profile & Settings
│       ├── controllers/# GetX state controllers
│       ├── models/     # Data models
│       └── screens/    # Profile, settings views
├── utils/              # SHARED UTILITIES
│   ├── constants/      # App-wide constants (colors, sizing, etc.)
│   ├── http/           # Custom HTTP clients
│   └── translations/   # I18N and Localization files
├── firebase_options.dart # Firebase initialization config
├── main.dart           # App Entry point
└── navigation_menu.dart# Main structural navigation setup
```
