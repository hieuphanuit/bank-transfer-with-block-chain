import 'package:flutter/material.dart';

// ----- bloc
import 'BLoC/device_bloc.dart';
import 'BLoC/activate_account_bloc.dart';
import 'BLoC/bloc_provider.dart';

// ----- screen
import 'Screens/Login/login_screen.dart';
import 'Screens/Home/home_screen.dart';
import 'Screens/GenerateQR/generate_qr_screen.dart';
import 'Screens/ActivateAccount/activate_account_screen.dart';
import 'Screens/Transaction/create_transfer_screen.dart';
import 'Screens/Transaction/create_cash_out_screen.dart';
import 'package:app/Screens/Profile/profile_screen.dart';
import 'package:app/Screens/Transaction/transaction_list_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app/Widget/Transaction/transaction_list_widget.dart';

void main() => runApp(BlocProvider(bloc: DeviceBloc(), child: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DeviceBloc _deviceBloc;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    //
    _deviceBloc = BlocProvider.of(context);

    // firebase
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      // init
      _deviceBloc.init(token: token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case LoginScreen.route:
            return MaterialPageRoute(builder: (_) => LoginScreen());
            break;
          case HomeScreen.route:
            return MaterialPageRoute(builder: (_) => HomeScreen());
            break;
          case ActivateAccountScreen.route:
            return MaterialPageRoute(
              builder: (_) => BlocProvider(
                bloc: ActivateAccountBloc(),
                child: ActivateAccountScreen(),
              ),
            );
            break;
          case GenerateQRScreen.route:
            String accountNumber = settings.arguments;
            return MaterialPageRoute(
                builder: (_) => GenerateQRScreen(accountNumber: accountNumber));
            break;
          case CreateTransferScreen.route:
            return MaterialPageRoute(builder: (_) => CreateTransferScreen());
            break;
          case CreateCashOutScreen.route:
            return MaterialPageRoute(builder: (_) => CreateCashOutScreen());
            break;
          case ProfileScreen.route:
            return MaterialPageRoute(builder: (_) => ProfileScreen());
            break;
          case TransactionListScreen.route:
            return MaterialPageRoute(builder: (_) => TransactionListScreen());
            break;
          // case TransactionWidget.route:
          //   return MaterialPageRoute(builder: (_) => TransactionWidget());
          //   break;
          default:
            return MaterialPageRoute(builder: (_) => LoginScreen());
        }
      },
    );
  }
}
