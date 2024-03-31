import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';
import 'package:the_market/utils/screens.dart';

class RouteGenerator {
  final StoreBloc storeBloc = StoreBloc();
  Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<StoreBloc>.value(
                value: storeBloc, child: const HomeScreen()));
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('lib/assets/error.jpg'),
            ),
            const TextWidget(
              text: 'Sorry Try Again',
              size: 24,
              color: AppColors.dark,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            const TextWidget(
              text: 'An error occurred while loading the product',
              maxLines: 2,
              size: 20,
              color: AppColors.dark,
            ),
            const SizedBox(height: 60),
            ButtonWidget(
                onPressed: () {
                  Navigator.pop(_);
                },
                color: AppColors.primary,
                textColor: AppColors.light,
                text: 'Try Again')
          ],
        ),
      );
    });
  }
}
