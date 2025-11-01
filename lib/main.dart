import 'package:firebase_core/firebase_core.dart';
import 'package:market_place_customer/bloc/multi_bloc_providers.dart';
import 'package:market_place_customer/utils/exports.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalStorage.init();
  await dotenv.load(fileName: ".env");

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
