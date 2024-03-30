import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';
import 'package:the_market/utils/screens.dart';

class RouteGenerator {
  final StoreBloc storeBloc = StoreBloc();
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider<StoreBloc>.value(
                value: storeBloc, child: const HomeScreen()));
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/error.png'),
            const TextWidget(
                text: 'ERROR',
                size: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.dark),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(_).pushNamed('/home');
                },
                color: AppColors.dark,
                textColor: AppColors.light,
                text: 'Go back home'),
          ],
        )),
      );
    });
  }
}
