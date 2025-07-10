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
import 'screens/new_deposit_screen.dart' as nds;
import 'screens/register_screen.dart';
import 'screens/safe_deposit_lockers_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with graceful error handling
  bool firebaseInitialized = false;
  try {
    await Firebase.initializeApp();
    firebaseInitialized = true;
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization failed: $e');
    print('App will continue without Firebase features');
    firebaseInitialized = false;
  }

  await Hive.initFlutter();
  await Hive.openBox('behaviorData');

  // Store Firebase status for use in other parts of the app
  final box = Hive.box('behaviorData');
  await box.put('firebaseAvailable', firebaseInitialized);

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
        '/login': (context) => GestureCaptureWrapper(child: LoginScreen(), screenName: 'LoginScreen'),
        '/home': (context) => GestureCaptureWrapper(child: HomeScreen(), screenName: 'HomeScreen'),
        '/accounts': (context) => GestureCaptureWrapper(child: AccountsScreen(), screenName: 'AccountsScreen'),
        '/transfer': (context) => GestureCaptureWrapper(child: TransferScreen(), screenName: 'TransferScreen'),
        '/transactions': (context) => GestureCaptureWrapper(child: TransactionsScreen(), screenName: 'TransactionsScreen'),
        '/debug': (context) => DebugDataScreen(),
        '/deposits': (context) => GestureCaptureWrapper(child: DepositsScreen(), screenName: 'DepositsScreen'),
        '/new-deposit': (context) => GestureCaptureWrapper(child: nds.NewDepositScreen(), screenName: 'NewDepositScreen'),
        '/safe_deposit_lockers': (context) => GestureCaptureWrapper(child: SafeDepositLockersScreen(), screenName: 'SafeDepositLockersScreen'),
        '/register': (context) => GestureCaptureWrapper(child: RegisterScreen(), screenName: 'RegisterScreen'),
      },
      navigatorObservers: [ScreenFlowObserver()],
    );
  }
}
