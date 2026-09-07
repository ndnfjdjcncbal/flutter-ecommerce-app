# Ecommerce Flutter App

A Flutter ecommerce application that provides product discovery, authentication,
search, cart management, favorites, addresses, orders, profile management, and
payment flows.

The application is built for Android, iOS, and other Flutter-supported platforms.

## Features

- Onboarding and language selection
- User registration, login, email verification, and password recovery
- Home page with banners, categories, and products
- Product search, filters, and search history
- Product details and color selection
- Favorites and cart management
- Address management and checkout
- Stripe and PayPal payment integrations
- Orders history
- Profile editing and password changes
- Firebase authentication, notifications, and cloud services
- Google Maps, geolocation, and address lookup
- Local persistence for session and application preferences
- Arabic and English localization
- Loading, empty, offline, and server-error states

## Technology Stack

- **Framework:** Flutter
- **Language:** Dart
- **State management:** GetX
- **Networking:** HTTP and Dio
- **Backend services:** PHP REST API and Firebase
- **Authentication:** Firebase Auth and application API authentication
- **Database and local storage:** Cloud Firestore, SQLite, and SharedPreferences
- **Payments:** Stripe and PayPal
- **Maps and location:** Google Maps, Geolocator, and Geocoding
- **Notifications:** Firebase Cloud Messaging and local notifications
- **UI utilities:** Cached Network Image, Lottie, SVG, and responsive layout helpers

## Architecture

The current application follows a **partial layered MVC architecture using GetX**.
It is intentionally described as layered MVC rather than full Clean Architecture,
because some legacy controllers still communicate directly with data sources and
some responses are represented as maps.

The main dependency flow is:

```text
View / Widgets
		|
		v
GetX Controllers
		|
		v
Data Sources / Services
		|
		v
CRUD HTTP Client / Firebase / Local Storage
```

Current responsibilities:

- `view/`: application pages and reusable UI widgets
- `controllers/`: screen state, user actions, and presentation logic
- `data/data_sources/`: API-specific operations
- `data/models/`: API and application data models
- `core/`: shared services, networking helpers, status handling, localization,
  middleware, and common utilities
- `app_routes.dart`: application routes and navigation configuration

For a concise explanation of the current architecture and request flow, see
[`ARCHITECTURE.md`](ARCHITECTURE.md).

## Feature Map

| Feature | UI | Controller | Data Source |
| --- | --- | --- | --- |
| Authentication | `view/auth/` | `controllers/auth/` | `data/data_sources/auth/` |
| Home and products | `view/HomeScreen/` | `controllers/Home/` | `data/data_sources/home/` |
| Search | `view/SearchScreen/` | `controllers/Search/` | `data/data_sources/Search/` |
| Cart and favorites | `view/cart/` | `controllers/Cart/` | `data/data_sources/car/`, `data/data_sources/favorite/` |
| Checkout and addresses | `view/checkout/`, `view/addres/` | `controllers/CheckOut/`, `controllers/Addres/` | `data/data_sources/checkout/`, `data/data_sources/address/` |
| Profile | `view/profile/` | `controllers/profile/` | `data/data_sources/profile/` |
| Maps and location | `view/widget/` | `controllers/Map/` | `core/` and API endpoints |
| Settings | `view/settings/` | `controllers/settings/` | `core/` |

## Project Structure

```text
lib/
├── controllers/        # GetX controllers grouped by application area
├── core/               # Shared infrastructure and application services
├── data/
│   ├── data_sources/   # Remote data source classes
│   └── models/         # API and local data models
├── view/               # Pages and UI widgets
├── app_routes.dart     # GetX route definitions
├── linkapi.dart        # Backend endpoint configuration
└── main.dart           # Application bootstrap
```

## Requirements

- Flutter SDK compatible with Dart `^3.10.8`
- Android Studio or Xcode, depending on the target platform
- A running ecommerce backend API
- Firebase project configuration for the selected platform
- Valid payment provider configuration when testing payments

## Getting Started

1. Clone the repository and open its directory:

	```bash
	git clone <repository-url>
	cd Ecommerce
	```

2. Install Flutter dependencies:

	```bash
	flutter pub get
	```

3. Configure Firebase for the selected platform.

4. Configure the backend endpoint in `lib/linkapi.dart`.

5. Configure payment credentials using secure environment or build-time
	configuration before running payment flows.

6. Run the application:

	```bash
	flutter run
	```

## Backend Configuration

The app communicates with a REST API for authentication, products, categories,
favorites, cart, addresses, orders, profile operations, and payments. Endpoint
constants are currently grouped in `lib/linkapi.dart`.

Before running the app, replace the development API URL with a reachable backend
URL for the selected device. Android emulators, physical devices, and iOS
simulators may require different network addresses when the backend runs locally.

## Security Notes

This repository is a development project and requires production hardening before
deployment:

- Do not commit private API keys, secret keys, or payment secrets.
- Do not expose Stripe secret keys in a Flutter client.
- Use HTTPS for all production API requests.
- Move environment-specific URLs and publishable configuration outside source code.
- Validate authentication and payment operations on the server.
- Use short-lived tokens and secure token storage for production sessions.
- Review Firebase security rules before enabling production data.

## Validation and Quality

Run the analyzer before opening a pull request:

```bash
flutter analyze
```

Run the test suite with:

```bash
flutter test
```

The project uses Flutter's standard lint configuration in `analysis_options.yaml`.

## Engineering Notes

- GetX is used for state management, routing, and dependency injection.
- Controllers should own presentation state and user actions, not HTTP details.
- Shared services belong in `core/`.
- API responses should gradually be converted from untyped maps into typed models.

## License

This project is private and is not published as a public package.
