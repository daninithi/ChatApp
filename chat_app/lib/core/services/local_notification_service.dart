import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  // private constructor for singleton pattern
  LocalNotificationService._internal();

  // singleton instance
  static final LocalNotificationService _instance = LocalNotificationService._internal();

  // factory constructor to return the singleton instance
  factory LocalNotificationService.instance() => _instance;

  // main plugin instance for handling notifications
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // Android-specific initialization settings using app launcher icon
  final _androidInitializationSettings = const AndroidInitializationSettings('@mipmap/ic_launcher');

    //Android notification channel configuration
  final _androidChannel = const AndroidNotificationChannel(
    'channel_id',
    'Channel name',
    description: 'Android push notification channel',
    importance: Importance.max,
  );

    //Flag to track initialization status
  bool _isFlutterLocalNotificationInitialized = false;

  //Counter for generating unique notification IDs
  int _notificationIdCounter = 0;

   /// Initializes the local notifications plugin for Android and iOS.
  Future<void> init() async {
    // Check if already initialized to prevent redundant setup
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    // Create plugin instance
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // Combine platform-specific settings
    final initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );

    // Initialize plugin with settings and callback for notification taps
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification tap in foreground
      print('Foreground notification has been tapped: ${response.payload}');
    });

    // Create Android notification channel
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    // Mark initialization as complete
    _isFlutterLocalNotificationInitialized = true;
  }

   /// Show a local notification with the given title, body, and payload.
  Future<void> showNotification(
    String? title,
    String? body,
    String? payload,
  ) async {
    // Android-specific notification details
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      _androidChannel.id,
      _androidChannel.name,
      channelDescription: _androidChannel.description,
      importance: Importance.max,
      priority: Priority.high,
    );

    // Combine platform-specific details
    final notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    // Display the notification
    await _flutterLocalNotificationsPlugin.show(
      _notificationIdCounter++,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

}