import 'package:the_market/models/products.dart';
import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';

import 'product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    // Dispatch an event here to fetch initial products based on the selected category
    context.read<StoreBloc>().add(CategoryProductRequested(selectedCategory));

    context.read<StoreBloc>().add(ProductRequested());
  }

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoriesListWidget(),
        SizedBox(height: 20),
      ],
    );
  }
}

String selectedCategory = 'All';

//Categories List Widget
class CategoriesListWidget extends StatefulWidget {
  const CategoriesListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  // Initialize with "All"
  @override
  void initState() {
    super.initState();
    selectedCategory = 'All';
  }

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      'All',
      "Smartphones",
      "Laptops",
      'Skincare',
      'Groceries',
      'Furniture',
      'Tops',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Categories',
                style: TextStyle(
                  color: AppColors.dark,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                )),
            Text('See all',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                )),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 46,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = categories[index];
                      CategoryProductRequested(selectedCategory);
                      StoreBloc()
                          .add(CategoryProductRequested(selectedCategory));
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selectedCategory == categories[index]
                          ? AppColors.primary
                          : AppColors.light,
                      border: selectedCategory == categories[index]
                          ? Border.all(color: AppColors.primary)
                          : Border.all(color: AppColors.dark),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        color: selectedCategory == categories[index]
                            ? AppColors.light
                            : AppColors.dark,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.5,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            if (state.productStatus == StoreRequest.loading) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).size.width > 600 ? 4 : 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio:
                        MediaQuery.of(context).size.width > 600 ? 0.7 : 0.6),
                itemCount: 14,
                itemBuilder: (context, index) {
                  return const ShimmerProductCard();
                },
              );
            }
            if (state.productStatus == StoreRequest.error) {
              return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Ionicons.alert_circle_outline,
                      color: AppColors.dark,
                      size: 50,
                    ),
                    const SizedBox(height: 20),
                    const TextWidget(
                      text: 'An error occurred',
                      color: AppColors.dark,
                      fontWeight: FontWeight.w600,
                      size: 20,
                    ),
                    const SizedBox(height: 40),
                    ButtonWidget(
                      onPressed: () {
                        selectedCategory == 'All'
                            ? context.read<StoreBloc>().add(ProductRequested())
                            : context.read<StoreBloc>().add(
                                CategoryProductRequested(selectedCategory));
                      },
                      text: 'Try again',
                      color: AppColors.primary,
                      textColor: AppColors.light,
                    )
                  ],
                ),
              );
            }
            if (state.productStatus == StoreRequest.unknown) {
              selectedCategory == 'All'
                  ? context.read<StoreBloc>().add(ProductRequested())
                  : context
                      .read<StoreBloc>()
                      .add(CategoryProductRequested(selectedCategory));
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 600 ? 4 : 2,
                  crossAxisSpacing: 20,
                  childAspectRatio:
                      MediaQuery.of(context).size.width > 600 ? 0.7 : 0.73),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                Products product = state.products[index];
                return ProductCard(
                  product: product,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(
                          productID: product.id,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        )
      ],
    );
  }
}
