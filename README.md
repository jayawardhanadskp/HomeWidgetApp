# Flutter Home Widget Demo

This is a Flutter project that demonstrates how to create and update a **Home Widget** for both **Android** and **iOS** platforms. The app allows users to increment a counter, and the widget dynamically updates to display the current value of the counter.

## Tech Stack

- **Flutter**: Used for building the cross-platform mobile app and managing the home widget's logic.
- **Dart**: Programming language used to develop the app.
- **home_widget Plugin**: A Flutter plugin to help you create and update home widgets for both Android and iOS.
- **Android Widgets**: The Android widget is created using `AppWidgetProvider` and `RemoteViews`.
- **iOS Widgets**: The iOS widget is created using **WidgetKit** and **SwiftUI**.

## Features

- **Increment counter**: The app increments a counter each time the user taps a button.
- **Dynamic widget update**: The widget displays the updated counter value.
- **Cross-platform support**: Works on both **Android** and **iOS** devices.
- **Shared data storage**: Uses shared data (via App Group) to share data between the Flutter app and the widget.

---

## **Set up Android Widget**
For Android, follow these steps:

- Modify the widget layout: In `android/src/main/res/layout/home_widget.xml`, design your widget UI.
- Update widget logic: Modify the `HomeWidget.kt` file under `android/src/main/kotlin/com/example/home_widget/` to update the widget when data is received from Flutter.
- Configure the widget: Make sure the widget uses RemoteViews to display the title fetched from shared storage.

  
## **Set up iOS Widget**
For iOS, follow these steps:

- Create a Widget Extension: In Xcode, go to `File > New > Target` and select Widget Extension. This will create a new widget target in your Xcode project.
- Modify widget logic: In `ios/Runner/Widget/HomeWidget.swift`, implement the widget logic to fetch the headline_title from shared storage (via App Groups).
- Configure App Group: Set up an App Group in both the app and widget targets to allow data sharing between the app and the widget.

## **Set up App Group for iOS**

To allow the app and widget to share data, you need to configure an App Group:

- In Xcode, navigate to your app target's Signing & Capabilities tab.
- Enable App Groups and create a new App Group with a unique identifier (e.g., group.HomeWidget).
- Enable the same App Group for the Widget Extension.
  

**Update widget data**

- The app stores the counter value using `HomeWidget.saveWidgetData<String>('headline_title', title)`.
- The widget listens for data changes and displays the updated value.
