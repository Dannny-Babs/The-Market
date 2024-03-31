import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';

class ProductScreen extends StatefulWidget {
  final int productID;
  const ProductScreen({super.key, required this.productID});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(ProductRequested(widget.productID));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state.productStatus == StoreRequest.unknown) {
          context.read<StoreBloc>().add(ProductRequested(widget.productID));
        }
        if (state.productStatus == StoreRequest.loading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  TextWidget(
                      text: 'Chill, I dey load...',
                      size: 20,
                      color: AppColors.dark),
                ],
              ),
            ),
          );
        }
        if (state.productStatus == StoreRequest.success) {
          final product = state.product.first;
          final inCart = state.cartIds.contains(product.id);
          final inFavorite = state.favoriteIds.contains(product.id);
          return buildProductScreen(inCart, inFavorite);
        }
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
                    context
                        .read<StoreBloc>()
                        .add(ProductRequested(widget.productID));
                  },
                  color: AppColors.primary,
                  textColor: AppColors.light,
                  text: 'Try Again')
            ],
          ),
        );
      },
    );
  }
}

Widget buildProductScreen(bool inCart, bool inFavorite) {
  return BlocBuilder<StoreBloc, StoreState>(
    builder: (context, state) {
      final product = state.product.first;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(EneftyIcons.arrow_left_3_outline,
                  color: AppColors.dark, size: 24),
              onPressed: () => Navigator.pop(context)),
          backgroundColor: AppColors.light,
          elevation: 0,
          title: const Center(
            child: TextWidget(
              text: 'Product Details',
              color: AppColors.dark,
              size: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<StoreBloc>().add(
                      inFavorite
                          ? FavoriteToggled(product.id)
                          : FavoriteRemoved(product.id),
                    );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    clipBehavior: Clip.hardEdge,
                    margin: const EdgeInsets.all(10),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    content: TextWidget(
                      text: inFavorite
                          ? 'Removed from favorites'
                          : 'Added to favorites',
                      color: AppColors.light,
                    ),
                    backgroundColor: AppColors.dark,
                  ),
                );
              },
              icon: inFavorite
                  ? const Icon(
                      EneftyIcons.heart_bold,
                      color: Colors.red,
                    )
                  : const Icon(
                      EneftyIcons.heart_outline,
                      color: AppColors.dark,
                    ),
            ),
          ],
        ),
        backgroundColor: AppColors.light,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          product.thumbnail,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextWidget(
                          text: product.title,
                          color: AppColors.dark,
                          size: 24,
                          fontWeight: FontWeight.bold),
                      TextWidget(
                        text: product.description,
                        size: 20,
                        color: AppColors.dark,
                      ),
                      const SizedBox(height: 10),
                      TextWidget(
                        text: '\$${product.price}',
                        size: 20,
                        color: AppColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.primary,
                          ),
                          TextWidget(
                            text: product.rating.toString(),
                            size: 20,
                            color: AppColors.dark,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ButtonWidget(
                        text: 'Add to Cart',
                        onPressed: () {
                          context
                              .read<StoreBloc>()
                              .add(ProductAddedToCart(product.id));

                          if (!inCart) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product added to cart'),
                              ),
                            );
                          }
                        },
                        color: AppColors.primary,
                        textColor: AppColors.light,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

/*
Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      product.thumbnail,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {
                          context
                              .read<StoreBloc>()
                              .add(FavoriteToggled(product.id));
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: product.title,
                        size: 24,
                        color: AppColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      TextWidget(
                        text: product.description,
                        size: 20,
                        color: AppColors.dark,
                      ),
                      const SizedBox(height: 10),
                      TextWidget(
                        text: '\$${product.price}',
                        size: 20,
                        color: AppColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: AppColors.primary,
                          ),
                          TextWidget(
                            text: product.rating.toString(),
                            size: 20,
                            color: AppColors.dark,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ButtonWidget(
                        text: 'Add to Cart',
                        onPressed: () {
                          context
                              .read<StoreBloc>()
                              .add(ProductAddedToCart(product.id));

                          if (!inCart) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product added to cart'),
                              ),
                            );
                          }
                        },
                        color: AppColors.primary,
                        textColor: AppColors.light,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );*/