import 'package:flutter/material.dart';
import 'package:raksha/screens/home_screen.dart';
import 'package:raksha/screens/login_screen.dart';
import 'package:raksha/screens/transactions_screen.dart';
import 'package:raksha/screens/transfer_screen.dart';
import 'package:raksha/screens/accounts_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'widgets/gesture_capture_wrapper.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'widgets/screen_flow_observer.dart';
import 'screens/debug_data_screen.dart';
import 'screens/deposits_screen.dart';
import 'screens/safe_deposit_lockers_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('behaviorData');

  // Set up background accelerometer listener
  accelerometerEvents.listen((event) async {
    final box = Hive.box('behaviorData');
    final orientationData = {
      'type': 'orientation',
      'x': event.x,
      'y': event.y,
      'z': event.z,
      'timestamp': DateTime.now().toIso8601String(),
    };
    await box.add(orientationData);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raksha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const GestureCaptureWrapper(child: LoginScreen(), screenName: 'LoginScreen'),
        '/home': (context) => const GestureCaptureWrapper(child: HomeScreen(), screenName: 'HomeScreen'),
        '/accounts': (context) => const GestureCaptureWrapper(child: AccountsScreen(), screenName: 'AccountsScreen'),
        '/transfer': (context) => const GestureCaptureWrapper(child: TransferScreen(), screenName: 'TransferScreen'),
        '/transactions': (context) => const GestureCaptureWrapper(child: TransactionsScreen(), screenName: 'TransactionsScreen'),
        '/debug': (context) => const DebugDataScreen(),
        '/deposits': (context) => const GestureCaptureWrapper(child: DepositsScreen(), screenName: 'DepositsScreen'),
        '/safe_deposit_lockers': (context) => const GestureCaptureWrapper(child: SafeDepositLockersScreen(), screenName: 'SafeDepositLockersScreen'),
      },
      navigatorObservers: [ScreenFlowObserver()],
    );
  }
}
