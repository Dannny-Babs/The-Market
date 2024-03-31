import 'package:the_market/interface/product_views.dart';
import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.light,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const TextWidget(
                text: 'Discover',
                fontWeight: FontWeight.w500,
                size: 28,
              ),
              const Spacer(),
              BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  final cartCount = state.cartIds.length;
                  return Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: AppColors.grey),
                        ),
                        child: const Icon(
                          EneftyIcons.bag_outline,
                          color: AppColors.dark,
                        ),
                      ),
                      if (cartCount > 0)
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: TextWidget(
                              text: cartCount.toString(),
                              color: AppColors.light,
                              fontWeight: FontWeight.w500,
                              size: 12,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              )
            ],
          ),
          backgroundColor: AppColors.light,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInUp(
                  animate: true,
                  child: SearchBarWidget(
                    hintText: 'Search',
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.001),
                const AnnouncementCardWidget(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                FadeInUp(animate: true, child: const ProductsScreen()),
              ],
            ),
          ),
        ));
  }
}

//Announcement Card Widget
class AnnouncementCardWidget extends StatelessWidget {
  const AnnouncementCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: Image.asset(
        'lib/assets/announcement.png',
        width: double.infinity,
      ),
    );
  }
}
