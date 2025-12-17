import 'package:firebase_core/firebase_core.dart';
import 'package:market_place_customer/bloc/multi_bloc_providers.dart';
import 'package:market_place_customer/utils/connection_status_listner.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'package:market_place_customer/utils/no_internet_screen.dart';

import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

//Initialize our singleton class for listening to changes.
initNoInternetListener() async {
  var connectionStatus = ConnectionStatusListener.getInstance();
  await connectionStatus.initialize();

  //We are checking initial status here. This will handle our app state when
  //it is started in no internet state.
  if (!connectionStatus.hasConnection) {
    updateConnectivity(false, connectionStatus);
  }

  //This callback will give us any changes in network
  connectionStatus.connectionChange.listen((event) {
    print("initNoInternetListener $event");
    updateConnectivity(event, connectionStatus);
  });
}

updateConnectivity(
    dynamic hasConnection, ConnectionStatusListener connectionStatus) {
  if (!hasConnection) {
    if (navigatorKey.currentContext != null) {
      connectionStatus.hasShownNoInternet = true;
      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => NoInternetPage(onRetry: () {}),
        ),
      );
    }
  } else {
    if (connectionStatus.hasShownNoInternet) {
      connectionStatus.hasShownNoInternet = false;
      //Handle internet is resumed here
      if (navigatorKey.currentContext != null) {
        Navigator.pop(navigatorKey.currentContext!);
      }
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorage.init();
  await dotenv.load(fileName: ".env");

  await initNoInternetListener();

  /// Start App
  runApp(const AppBlocProviders(child: MyApp()));

  /// EasyLoading config
  configLoading();
}

late Size size;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market Place',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteColor,
        fontFamily: 'AlanSans',
        appBarTheme: const AppBarTheme(
            centerTitle: false,
            backgroundColor: AppColors.whiteColor,
            iconTheme: IconThemeData(color: AppColors.blackColor)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(textScaleFactor: 1.0),
          child: EasyLoading.init()(context, child),
        );
      },
    );
  }
}
