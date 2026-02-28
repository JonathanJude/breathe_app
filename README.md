# Breathe App

A box-breathing app built with Flutter (mobile + web).  
Users can configure breathing pace, rounds, advanced phase timings, sound cues, and run guided sessions with animated breathing flow.

App Overview: https://www.loom.com/share/9f8bdf49f0cc45f1b8473489350c7856 
Codebase & Architecure rundown: https://www.loom.com/share/e508385db1b343e5b5111e03886ba02f 

## Architecture

The app uses a **feature-first Clean Architecture** structure:

- `presentation`: pages, widgets, BLoC/Cubit
- `domain`: entities, repository contracts, use cases
- `data`: datasource/models/repository implementations
- `core`: shared services (DI, persistence, audio, theme, reusable widgets)

Main feature lives under:

- `lib/features/breathing/`

## State Management

State is managed with **BLoC/Cubit**:

- `BreathingBloc`: session flow, timing, phase transitions, progress, persistence sync
- `ThemeCubit`: light/dark mode state + persistence

Dependencies are wired with **GetIt**.

## Run the App

1. Install dependencies:

```bash
flutter pub get
```

2. Run on mobile/emulator:

```bash
flutter run
```

3. Run on web:

```bash
flutter run -d chrome
```

4. Build web release:

```bash
flutter build web --release
```
