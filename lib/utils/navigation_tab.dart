import 'package:the_market/interface/home_screen.dart';
import 'package:the_market/utils/bloc.dart';
import '../utils/packages.dart';

List<BottomNavigationBarItem> bottomNavBarItems = const [
  BottomNavigationBarItem(
    icon: Icon(Ionicons.home),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(Ionicons.search),
    activeIcon: Icon(Ionicons.search_sharp),
    label: 'Search',
  ),
  BottomNavigationBarItem(
    icon: Icon(Ionicons.heart_outline),
    activeIcon: Icon(Ionicons.heart),
    label: 'Favorites',
  ),
  BottomNavigationBarItem(
    icon: Icon(Ionicons.person_outline),
    activeIcon: Icon(Ionicons.person),
    label: 'Profile',
  ),
];

const List<Widget> bottomNavBarScreens = [
  HomeScreen(),
  Text('Search'),
  Text('Favorites'),
  Text('Profile'),
  //SearchScreen(),
  //FavoritesScreen(),
  // ProfileScreen(),
];

class BottomTabBar extends StatelessWidget {
  const BottomTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreBloc, StoreState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: bottomNavBarScreens[state.tabIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavBarItems,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: const Color(0xFF727272),
            showUnselectedLabels: true,
            landscapeLayout: BottomNavigationBarLandscapeLayout.spread,
            currentIndex: state.tabIndex,
            onTap: (index) {
              context.read<StoreBloc>().add(TabChanged(index));
            },
          ),
        );
      },
    );
  }
}
