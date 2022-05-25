## Setup application
- flutter add local_auth
- flutter pub get
- flutter pub run build_runner build --delete-conflicting-outputs

## To Integrate
- Go to **AndroidManifest.xml** (Main) add:
  ```
    <uses-permission android:name="android.permission.USE_FINGERPRINT"/>
 
  ```
- Go to **MainActivity.kt** and replace everything except for package name with:
  ```
    import io.flutter.embedding.android.FlutterFragmentActivity
    import io.flutter.plugins.GeneratedPluginRegistrant
    import io.flutter.embedding.engine.FlutterEngine
    import androidx.annotation.NonNull;

    class MainActivity: FlutterFragmentActivity() {
        override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
            GeneratedPluginRegistrant.registerWith(flutterEngine);
        }
    }

  ```
## Important files:

- lib/infrastructures/local_auth.dart
- lib/main.dart
  ```

   Future<void> _authenticateUser() async {
    final String res = await LocalAuthApi.authenticate(
      messageReason: 'Authenticate to access app flirt',
    );
    if (res == 'authenticated') {
      // navigate to home page since it is authenticated
      setState(() => _isAuthenticated = true);
    } else if (res == 'NotEnrolled') {
      // informs the user that they need to enroll biometrics such as finger print or face id
      log(res);
    } else if (res.contains('Device is not supported')) {
      // informs the user that they need to setup password either pin,etc.
      log(res);
    } else {
      //if the authenticatoin is failed then app will automatically exitted
      SystemNavigator.pop();
    }
  }

  ```

## error usally encountered: 

- android build file gradle-wrapper.properties:
  ```
   distributionUrl=https\://services.gradle.org/distributions/gradle-6.1.1-all.zip

  ```
## Credits to: 
- [Flutter Tutorial - Fingerprint & Touch ID - Local Auth](https://www.youtube.com/watch?v=qTuVurGvdbM)
- [Github Code resources](https://github.com/JohannesMilke/fingerprint_auth_example)