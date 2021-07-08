# Peer-to-peer payment integration to a messaging app using Flutter 💰

This project shows how to integrate a peer-to-peer payment solution to your [Stream Chat](https://getstream.io/) using [Rapyd's](https://www.rapyd.net/) Wallet API with the help of Flutter.

![App in action](screenshots/final_app.gif)

## Project structure 🏗️

The `lib` directory contains the Dart code of the Flutter app, it is distributed in the following directories:

* **screens:** contains all the Flutter app screens
* **widgets:** contains various widgets which are used inside the screens
* **utils:** contains the utility classes for connecting to the Wallet API
* **models:** contains the model classes for easy storing of API data
* **res:** contains the color palette used in the app

## Requirements 🧪

Some prerequisites to run this project:

* **Flutter 2 with null safety enabled** (it is tested on Flutter v2.2.3): You can install it from the [Flutter website](https://flutter.dev/docs/get-started/install).

* **Setup Stream account:** You can sign up for a Stream account at [getstream.io](https://getstream.io/dashboard/signup), and get the free trial of Stream's Chat Messaging by going [here](https://getstream.io/chat/trial/).

* **Setup Rapyd account:** You can sign up for a Rapyd account [here](https://dashboard.rapyd.net/sign-up), and enable their Sandbox mode.

## Usage 👨‍💻

For building and running this project locally, follow the steps below:

* Clone this repository:

   ```sh
   git clone https://github.com/sbis04/stream_payment.git
   ```

* Navigate to the project directory:
  
  ```sh
  ch stream_payment
  ```

* Get Flutter dependencies:
  
  ```sh
  flutter pub get
  ```

* Create a `secrets.dart` dart file inside the `lib` directory with the following content:
  
  ```dart
  // Stream secrets
  const STREAM_KEY = 'stream-key-here';
  const USER_TOKEN = 'stream-user-token-here';

  // Rapyd secrets
  const RAPYD_ACCESS_KEY = 'rapyd-access-key-here';
  const RAPYD_SECRET_KEY = 'rapyd-secret-key-here';
  ```

  > You can generate the Stream user token from [here](https://getstream.io/chat/docs/react/token_generator/).

* Run the app:
  
  ```sh
  flutter run
  ```

## License 📝

Copyright (c) 2021 Souvik Biswas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
