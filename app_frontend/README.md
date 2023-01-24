# app_frontend

A new Flutter project.



```flutter create app_frontend```

```flutter pub add url_launcher```

```dart pub add qr_code_scanner```




```
android {
    compileSdkVersion 33
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.app_frontend"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-build-configuration.
        minSdkVersion 21
        targetSdkVersion 28
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
```

### For Debug APK :

```flutter build apk```

### For Release APK :

```flutter build apk --release```

### For App Bundle :

``` flutter build appbundle```

