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
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: AppColors.grey),
                ),
                child: const Icon(
                  Ionicons.basket_outline,
                  color: AppColors.dark,
                ),
              )
            ],
          ),
          backgroundColor: AppColors.light,
          elevation: 0.0,
        ),
        body: Padding(
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.035),
              const AnnouncementCardWidget(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              FadeInUp(animate: true, child: const CategoriesListWidget()),
            ],
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
    return Stack(
      clipBehavior: Clip.none,
      children: [
        FadeInUp(
          animate: true,
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const TextWidget(
                  text: 'Clearance\nSales',
                  color: AppColors.light,
                  fontWeight: FontWeight.w600,
                  maxLines: 2,
                  size: 34,
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const TextWidget(
                    text: 'Up to 50% off',
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * -0.038,
          right: -40,
          child: Image.asset(
            'lib/assets/iphone.png',
            width: MediaQuery.of(context).size.width * 0.83,
          ),
        )
      ],
    );
  }
}

//Categories List Widget
class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'All',
      "Smartphones",
      "Laptops",
      "Skincare",
      "Groceries",
      "Furniture",
      "Tops",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(
              text: 'Categories',
              color: AppColors.dark,
              fontWeight: FontWeight.w700,
              size: 20,
            ),
            TextWidget(
              text: 'See all',
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              size: 16,
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              bool isSelected = false;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isSelected = !isSelected;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? AppColors.primary : AppColors.light,
                          border: isSelected
                              ? Border.all(width: 0)
                              : Border.all(color: AppColors.dark),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextWidget(
                          text: categories[index],
                          color: AppColors.dark,
                          fontWeight: FontWeight.w600,
                          size: 16.5,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
