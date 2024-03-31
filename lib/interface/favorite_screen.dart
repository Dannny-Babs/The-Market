import '../utils/packages.dart';
import '../utils/bloc.dart';
import '../utils/screens.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    context.read<StoreBloc>().add(CategoryProductRequested ('all'));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        final favoriteProducts = state.products
            .where((product) => state.favoriteIds.contains(product.id))
            .toList();
        if (state.favoriteIds.isEmpty) {
          return const Center(
            child: Text('No favorite products'),
          );
        }
        return Scaffold(
          backgroundColor: AppColors.light,
          appBar: AppBar(
            backgroundColor: AppColors.light,
            elevation: 0,
            title: const TextWidget(
              text: 'Favorites',
              color: AppColors.dark,
              size: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Favorite Products: ${favoriteProducts.length}',
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF9C9C9C))),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 4 : 2,
                        crossAxisSpacing: 20,
                        childAspectRatio:
                            MediaQuery.of(context).size.width > 600
                                ? 0.7
                                : 0.73),
                    itemCount: favoriteProducts.length,
                    itemBuilder: (context, index) {
                      final product = favoriteProducts[index];
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

