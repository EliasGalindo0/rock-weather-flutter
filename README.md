# Weather Rock'n'Roll

Weather Rock'n'Roll is a Flutter application designed to track the current weather and the forecast for the next 5 days for a rock'n'roll band staff. The app includes two main screens: one for current weather and another for the 5-day forecast. It also provides a list of concert cities with a search field to find cities by name.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Screens](#screens)
- [Offline Support](#offline-support)
- [Contributing](#contributing)
- [License](#license)

## Features

- Display current weather for selected cities.
- Display 5-day weather forecast.
- Search for concert cities.
- Works offline (data is cached locally).
- Supports multiple resolutions and screen sizes.

## Installation

1. Ensure you have Flutter installed. If not, follow the official Flutter [installation guide](https://flutter.dev/docs/get-started/install).

2. Clone this repository:

    ```sh
    git clone https://github.com/yourusername/weather_rocknroll.git
    cd weather_rocknroll
    ```

3. Install the dependencies:

    ```sh
    flutter pub get
    ```

## Usage

1. Run the application:

    ```sh
    flutter run
    ```

2. Use the application to check the current weather and forecast for the listed cities.

## Screens

### Concert Cities Screen

- Lists the concert cities.
- Provides a search field to filter cities by name.
- Allows navigation to the current weather and 5-day forecast screens.

### Current Weather Screen

- Displays the current temperature, weather condition, and corresponding icon for the selected city.
- Provides a button to navigate to the 5-day forecast screen.

### 5-Day Forecast Screen

- Displays a table with the 5-day weather forecast for the selected city.
- Includes date, temperature, weather condition, and corresponding icon.

## Offline Support

The app caches weather data locally using `shared_preferences`, ensuring that previously fetched weather data is available even when offline.

## Project Structure

```plaintext
lib/
|-- main.dart
|-- services/
|   |-- api_service.dart
|-- screens/
    |-- concerts_screen.dart
    |-- current_weather_screen.dart
    |-- forecast_screen.dart

```
## Contributing

 - Fork the repository.
 - Create your feature branch (git checkout -b feature/your-feature).
 - Commit your changes (git commit -m 'Add some feature').
 - Push to the branch (git push origin feature/your-feature).
 - Open a pull request.# rock-weather-flutter
