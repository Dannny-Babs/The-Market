import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/screens.dart';
import '../utils/packages.dart';

List<BottomNavigationBarItem> bottomNavBarItems = const [
  BottomNavigationBarItem(
    icon: Icon(EneftyIcons.home_outline),
    activeIcon: Icon(EneftyIcons.home_bold),
    label: 'Home',
  ),
  BottomNavigationBarItem(
    icon: Icon(EneftyIcons.search_normal_outline),
    activeIcon: Icon(EneftyIcons.search_normal_bold),
    label: 'Search',
  ),
  BottomNavigationBarItem(
    icon: Icon(EneftyIcons.heart_outline),
    activeIcon: Icon(EneftyIcons.heart_bold),
    label: 'Favorites',
  ),
  BottomNavigationBarItem(
    icon: Icon(EneftyIcons.profile_outline),
    activeIcon: Icon(EneftyIcons.profile_bold),
    label: 'Profile',
  ),
];

const List<Widget> bottomNavBarScreens = [
  HomeScreen(),
  SearchScreen(),
  FavoriteScreen(),
  Text('Profile'),

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
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(12),
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: FontWeight.w500,
              ),
              backgroundColor: Colors.white,
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
          ),
        );
      },
    );
  }
}
