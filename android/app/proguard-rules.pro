# Keep all Razorpay SDK classes
-keep class com.razorpay.** { *; }

# Keep Google Pay client (used by Razorpay)
-keep class com.google.android.apps.nbu.paisa.inapp.client.api.** { *; }

# Keep annotation classes
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# Keep Firebase & Google Play
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep Flutter plugin classes
-keep class io.flutter.plugins.** { *; }

# Keep Kotlin metadata
-keep class kotlin.Metadata { *; }
-dontwarn kotlin.**

# Prevent warnings from missing classes
-dontwarn com.google.android.apps.nbu.paisa.inapp.client.api.**
-dontwarn proguard.annotation.**
-dontwarn com.razorpay.**
