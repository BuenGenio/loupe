import Flutter
import UIKit
import UserNotifications
import flutter_foreground_task
import flutter_local_notifications
import workmanager_apple

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  /// The background sync's BGAppRefreshTask: the same identifier is in
  /// Info.plist (BGTaskSchedulerPermittedIdentifiers) and in Dart
  /// (`iosRefreshTask`, app/lib/platform/work_scheduler.dart).
  static let refreshTask = "io.github.buengenio.loupe.sync"

  /// The earliest iOS may run the next refresh after one ends (Dart:
  /// `AppRefreshScheduler.period`). iOS decides when it really runs.
  static let refreshEvery: TimeInterval = 15 * 60

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // New-mail notifications: iOS asks the app delegate about taps, buttons
    // and notifications that arrive while the app is open, and
    // FlutterAppDelegate passes that on to flutter_local_notifications. It
    // has to be set before launch finishes.
    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate

    // Background work runs in engines of its own, without UI: Archive and
    // Mark as Read on a notification, and the background sync. They need
    // the plugins too. Set here rather than in
    // didInitializeImplicitFlutterEngine: when iOS launches Loupe only in
    // the background, no scene connects and that callback never comes.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }
    WorkmanagerPlugin.setPluginRegistrantCallback { registry in
      GeneratedPluginRegistrant.register(with: registry)
    }

    // BGTaskScheduler only accepts launch handlers until launch finishes,
    // and with the UIScene life cycle the plugins register later than that.
    WorkmanagerPlugin.registerPeriodicTask(
      withIdentifier: AppDelegate.refreshTask,
      earliestBeginInSeconds: NSNumber(value: AppDelegate.refreshEvery)
    )
    WorkmanagerPlugin.registerLaunchHandlers()

    // flutter_foreground_task runs Instant Delivery, which is Android only
    // (iOS allows no lasting connection). Its iOS half still registers a
    // BGTaskScheduler handler of its own when it gets the launch event, and
    // with UIScene Flutter sends that event after launch, when registering
    // is no longer allowed. Let it register now, inside the launch: its
    // identifier isn't in Info.plist, so iOS just declines, and the late
    // call becomes a no-op.
    _ = SwiftFlutterForegroundTaskPlugin().application(application, didFinishLaunchingWithOptions: [:])

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
  }
}
