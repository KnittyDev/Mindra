import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        // Handle notification tap
      },
    );
  }

  Future<void> requestPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> showInstantNotification() async {
    await flutterLocalNotificationsPlugin.show(
      1,
      'Test Notification',
      'This is a test notification to verify settings. 🚀',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_motivation_channel',
          'Daily Motivation',
          channelDescription: 'Daily reminders to reflect and relax',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> updateSchedule(int frequency, TimeOfDay startTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notification_frequency', frequency);
    await prefs.setInt('start_hour', startTime.hour);
    await prefs.setInt('start_minute', startTime.minute);
    await scheduleDailyNotification();
  }

  Future<void> scheduleDailyNotification() async {
    // Cancel existing notifications
    await flutterLocalNotificationsPlugin.cancelAll();

    final prefs = await SharedPreferences.getInstance();
    final int frequency = prefs.getInt('notification_frequency') ?? 1;
    final int startHour = prefs.getInt('start_hour') ?? 9;
    final int startMinute = prefs.getInt('start_minute') ?? 0;

    // Calculate interval in minutes to support finer granularity if needed, 
    // but for now we'll stick to rough hourly distribution for simplicity
    // spread between startHour and (startHour + 12) or similar.
    // Let's keep it simple: Spread over 12 hours active period.
    
    // Active period duration (e.g. 12 hours)
    final int activePeriodHours = 12;
    final double intervalHours = activePeriodHours / frequency;

    for (int i = 0; i < frequency; i++) {
        // Calculate target hour and minute
        final double offset = i * intervalHours;
        int hour = startHour + offset.floor();
        int minute = startMinute + ((offset - offset.floor()) * 60).round();
        
        // Handle overflow (next day) logic is handled by _nextInstance
        if (hour >= 24) hour -= 24;

        await flutterLocalNotificationsPlugin.zonedSchedule(
          i,
          'Daily Motivation',
          'Time to take a moment for yourself. 🌿',
          _nextInstanceOfTime(hour, minute),
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'daily_motivation_channel',
              'Daily Motivation',
              channelDescription: 'Daily reminders to reflect and relax',
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: DarwinNotificationDetails(),
          ),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
