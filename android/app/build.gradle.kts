plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.rank_up"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.rank_up"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // MUST for Google Sign-In
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BOM
    implementation(platform("com.google.firebase:firebase-bom:32.2.2"))

    // Firebase Auth
    implementation("com.google.firebase:firebase-auth-ktx")

    // Google Play Services Auth (🔥 THIS WAS MISSING)
    implementation("com.google.android.gms:play-services-auth:20.7.0")

    // Multidex support (🔥 REQUIRED FOR GOOGLE SIGN-IN POPUP)
    implementation("androidx.multidex:multidex:2.0.1")

    // Java 11 API support
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.3")
}
