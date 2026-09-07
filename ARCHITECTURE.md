# Architecture Guide

## Current Architecture

This application uses a partial layered MVC architecture with GetX.

It is not full Clean Architecture. Some controllers still communicate directly
with data sources, and some API responses are represented as maps. This guide
describes the current codebase accurately so that new contributors can navigate
it without assuming boundaries that do not exist yet.

## Dependency Flow

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

## Layer Responsibilities

### Presentation: `lib/view/`

Contains application pages and reusable widgets. Pages render state, collect
user input, and trigger controller actions.

### Controllers: `lib/controllers/`

Contains GetX controllers grouped by application area. Controllers manage screen
state, user actions, navigation decisions, and loading/error states.

### Data: `lib/data/`

- `data_sources/`: API-specific operations and remote data access.
- `models/`: Models used to represent API and application data.

### Core: `lib/core/`

Contains shared infrastructure such as the HTTP CRUD helper, status handling,
local services, localization, middleware, constants, and reusable functions.

### Application Entry Points

- `lib/main.dart`: Initializes Firebase, local storage, Stripe, and the app.
- `lib/app_routes.dart`: Defines GetX routes and their pages.
- `lib/linkapi.dart`: Contains backend endpoint constants.

## Typical Request Flow

For a typical API-backed screen:

```text
Page
  -> GetX Controller
  -> Data Source
  -> CRUD HTTP Client
  -> REST API
```

The controller updates the view after the request completes by changing its state
and calling the appropriate GetX update mechanism.

## Main Areas

| Area | Main location | Responsibility |
| --- | --- | --- |
| Authentication | `lib/controllers/auth/` | Login, signup, and verification |
| Home | `lib/controllers/Home/` | Banners, categories, and products |
| Search | `lib/controllers/Search/` | Search, filters, and search history |
| Cart | `lib/controllers/Cart/` | Cart items and favorites |
| Checkout | `lib/controllers/CheckOut/` | Address, order, and payment flow |
| Profile | `lib/controllers/profile/` | Profile and password operations |
| Location | `lib/controllers/Map/` | Maps, geolocation, and addresses |
| Settings | `lib/controllers/settings/` | Application settings |

## Working Rules

- Keep UI rendering inside `view/`.
- Keep screen state and user actions inside controllers.
- Put API endpoint calls in data sources.
- Put shared infrastructure in `core/`.
- Prefer typed models instead of adding new untyped maps.
- Use existing GetX bindings and dependency injection patterns.
- Do not rename legacy files without updating every import and testing the app.

## Future Improvements

These are incremental improvements, not requirements for the current app:

1. Introduce repository interfaces between controllers and data sources.
2. Convert API maps into typed models at the data boundary.
3. Move complex business rules into use cases.
4. Add focused tests for authentication, cart calculations, checkout, and payment.
5. Keep independently developed Delivery and Admin applications in separate
   repositories with their own architecture and documentation.
