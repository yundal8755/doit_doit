This file gives focused, actionable guidance for automated coding agents working in the Doit Doit Flutter app.

High level architecture
- Flutter app using Riverpod (v2) for state management and a clean-architecture inspired feature split: `feature/` (usecases, repositories, datasources) + `presentation/` (pages, providers, widgets).
- Dependency wiring is done with Riverpod provider functions in `lib/app/di/*.dart` (e.g. `auth_di.dart`, `todo_di.dart`). Prefer editing DI via these files rather than sprinkling new global singletons.
- Firebase-backed domain: Firestore + Firebase Auth are central. Remote datasources live under `feature/*/datasource/*_remote_datasource_impl.dart` and use `FirebaseFirestore.instance` / `FirebaseAuth.instance`.

Entrypoints & flavors
- App boots from flavor-specific entrypoints in `lib/app/entrypoint/` (e.g. `main_dev.dart`, `main_prod.dart`). Use `F.runFlavoredApp(flavor: Flavor.dev|prod)` to initialize environment.
- Flavors and environment-specific Firebase options are in `lib/app/environment/flavors.dart` and `lib/app/environment/firebase_options/`.
- .env is loaded at startup and required keys include `kakao_login_key` and Naver credentials. If any are missing, app init throws.

State, usecases, and providers
- Business logic lives in `feature/*/usecase/*.dart`. Repositories define contracts (`feature/*/repository/*.dart`) and implementations (`*_impl.dart`). Example: `FetchTodoListUsecase` calls `TodoRepository.fetchTodoList` then sorts into buckets.
- Riverpod code-generation is used: look for `@riverpod` annotations and generated `*.g.dart` files under `lib/presentation/provider/` and `lib/app/di/`.
- Prefer calling usecases from providers (e.g. `fetch_todo_provider.dart` reads `fetchTodoListUsecaseProvider`) and handling Result<> (project-specific Result wrapper in `app/module/error_handling/result.dart`).

External integrations and patterns
- Firebase: initialized with flavor-specific options. Files to inspect: `lib/app/environment/flavors.dart`, `lib/feature/*/datasource/*_remote_ref.dart` (these return Firestore collection refs).
- Social login: Google, Apple, Kakao, Naver are supported. Auth flows are implemented in `feature/auth/datasource/auth_remote_datasource_impl.dart` and consumed by `feature/auth/repository/*` and usecases.
- Deleting user needs re-auth flow handling — see `deleteCurrentUser()` for provider-specific reauth strategies (google/apple) and special error handling for `requires-recent-login`.

Developer workflows (how to build, run, test)
- Run dev flavor: `flutter run -t lib/app/entrypoint/main_dev.dart` (or run configuration for that entrypoint). For prod: `flutter run -t lib/app/entrypoint/main_prod.dart`.
- Firebase files for flavors are under `android/app/src/{dev,prod}` and `ios/config/{dev,prod}`; ensure `GoogleService-Info.plist` / `google-services.json` are present for the target flavor.
- Codegen: Riverpod uses annotations. Run `flutter pub run build_runner build --delete-conflicting-outputs` after changing `@riverpod` or `riverpod_annotation` usage.

Conventions & gotchas (specific to this repo)
- DI via Riverpod provider functions (files in `lib/app/di/`) — do not add manual global singletons. Register new repositories/usecases in the appropriate `*_di.dart` file.
- Error handling uses a Result<T> wrapper in `app/module/error_handling/result.dart`. Use `Result.success` / `Result.failure` and fold when consumed by providers. Providers often convert Result into AsyncValue and log via `AppLog`.
- Sorting logic and display-ready transformations live in usecases (e.g. `FetchTodoListUsecase` sorts by priority and dates). Keep UI presentation minimal and reuse usecase outputs.
- Localization uses `easy_localization`; initialization happens in `flavors.dart`. Keep translation files in `assets/translations/`.

Where to look for examples
- Entrypoint / flavors: `lib/app/entrypoint/main_dev.dart`, `lib/app/environment/flavors.dart`.
- DI pattern: `lib/app/di/auth_di.dart`, `lib/app/di/todo_di.dart`.
- Auth datasource & reauth: `lib/feature/auth/datasource/auth_remote_datasource_impl.dart`.
- Firestore refs: `lib/feature/todo/datasource/todo_remote_ref.dart`, `lib/feature/user/datasource/remote/user_remote_ref.dart`.
- Usecase → provider flow: `lib/feature/todo/usecase/fetch_todo_list_usecase.dart` and `lib/presentation/provider/todo/fetch_todo_provider.dart`.

What automated agents should do first
1) Run static checks and codegen: `flutter pub get` then `flutter pub run build_runner build --delete-conflicting-outputs`.
2) Run unit/widget tests in `test/` (small project uses `test/widget_test.dart`); if adding tests, follow the existing style.
3) When modifying state/DI, update the corresponding `lib/app/di/*.dart` provider and regenerate Riverpod files.

If you modify Firebase / flavor behavior
- Update `flavorizr.yaml` if you add a new flavor. Ensure android ios flavor configs and firebase config files are added to `android/app/src/` and `ios/config/` respectively.

If anything in this file is ambiguous or you need more examples (e.g. CI commands, linters, or platform-specific notes), say which area to expand and include the target files or workflows you want documented.
