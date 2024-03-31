import 'package:the_market/bloc/store_bloc.dart';
import 'package:the_market/data/routes.dart';
import 'package:the_market/utils/navigation_tab.dart';
import 'package:the_market/utils/packages.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => StoreBloc(),
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
          textTheme: GoogleFonts.plusJakartaSansTextTheme(),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
              .copyWith(primary: AppColors.primary)
              .copyWith(background: AppColors.light),
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator().generateRoute,
        home:  BottomTabBar());
  }
}
