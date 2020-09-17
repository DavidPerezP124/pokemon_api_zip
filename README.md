# pokemon_api_zip

Flutter example Project using PokemonApi through Http calls.

This project is compatible with phones and tables.

Since it's responsive it is also a responsive Progressive Web App.

## Getting Started

To  Install Flutter:

[Oficial Flutter Page](https://flutter.dev/docs/get-started/install)

## To clone this repo just paste this in your Terminal

To run in a chrome browser (easiest setup)

```console
git clone https://github.com/DavidPerezP124/pokemon_api_zip.git
# To run this project
cd pokemon_api_zip
flutter run -d chrome
```

If web development is not enabled:

```console
#You need to change to beta channel
flutter channel beta
flutter upgrade
flutter config --enable-web
```

To run in device:

```console
git clone https://github.com/DavidPerezP124/pokemon_api_zip.git
# To run this project
cd pokemon_api_zip
flutter run
```

You need a physical device or emulator.
Select that device in your IDE before executing `flutter run` command


### Login

Username and Pass word validity are checked with Regex

### Home

Load only 100 pokemon, and see random picks of 5 of these.
Change to next 100 and previous 100, with the buttons.

### Dependencies

#### UI dependencies

  google_fonts: ^1.1.0 :
  
  This lets you use any google font, and is easy to setup for TextThemes

#### Business Logic

  provider: ^4.3.2+2:

Provider eases a Bloc pattern state management by streamlining disposal and creation of a data layer.

##### Http Calls
  
  http: ^0.12.2
  
  For API calls, this automates client creation and disposal with http.get("url")

##### Local Data Persistance

  shared_preferences: ^0.5.10

Now compatible with web, this permits the usage of native simple data persistance.

## To-Do

- [x] iOS compatible
- [X] Android Compatible
- [X] Web Compatible
- [ ] Setup more test to aim for min: 80% code coverage
- [ ] CI/CD Integration
- [ ] Containerize for remote development
