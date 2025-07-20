# 📚 Book Finder Flutter App

A Book Finder Flutter app using **Clean Architecture**, **BLoC**, **SQLite**, and **Localization**, allowing users to search books from an API, view details, and save books offline.

---

## 🚀 Features

- ✅ Search books via public API
- ✅ Animated book cover on details screen (rotation)
- ✅ Save favorite books to local storage (SQLite)
- ✅ View saved books offline
- ✅ Clean Architecture (Presentation, Domain, Data layers)
- ✅ BLoC for state management
- ✅ GetIt for dependency injection
- ✅ Pull-to-refresh, pagination support
- ✅ Multi-language support (English, Hindi)
- ✅ Unit tests with bloc\_test and mockito

---

## 🗂️ Project Structure

```
lib/
 ├── core/               # Dependency injection, constants
 ├── data/               # API calls, local storage, repository implementation
 ├── domain/             # Entities, UseCases, Repository interfaces
 ├── presentation/       # Screens, Widgets, BLoC
 ├── generated/          # Localization generated files
 ├── l10n/               # .arb files for translations
 └── main.dart
```

---

## 📥 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/book-finder-app.git
cd book-finder-app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Localization Files

```bash
flutter gen-l10n
```

### 4. Run the App

```bash
flutter run
```

---

## 🧪 Testing

```bash
flutter test
```

Includes unit tests for:

- ✅ UseCases
- ✅ BLoC
- ✅ Mocked Repositories

---

## 🌐 Localization Setup

Currently supports:

- ✅ English 🇺🇸 (`intl_en.arb`)

To add more languages, edit or add files under `lib/l10n/`.

---

## 📸 Screenshots

| Search Books | Book Details | Saved Books |
| ------------ | ------------ | ----------- |
|              |              |             |

---

## 📌 Tech Stack

| Tech                 | Usage                  |
| -------------------- | ---------------------- |
| Flutter              | App Framework          |
| BLoC                 | State Management       |
| Dio                  | API Integration        |
| GetIt                | Dependency Injection   |
| Sqflite              | Local Database         |
| bloc\_test + mockito | Unit Testing           |
| intl                 | Multi-language support |

---


