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
          if (state.product.isNotEmpty) {
            // Check if the list is not empty
            final product = state.product.first;
            final inCart = state.cartIds.contains(product.id);
            final inFavorite = state.favoriteIds.contains(product.id);
            return buildProductScreen(inCart, inFavorite);
          } else {
            return const Scaffold(
              body: Center(
                child: Text('No products found'),
              ),
            );
          }
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

SnackBar _buildSnackBar(String message) {
  return SnackBar(
    clipBehavior: Clip.hardEdge,
    margin: const EdgeInsets.all(10),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    content: TextWidget(
      text: message,
      color: AppColors.light,
    ),
    backgroundColor: AppColors.dark,
  );
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
              size: 22,
              fontWeight: FontWeight.w600,
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
                  _buildSnackBar(
                    inFavorite
                        ? 'Product removed from favorites'
                        : 'Product added to favorites',
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
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.grey,
                            width: 1,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            product.thumbnail,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                            itemCount: product.images.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppColors.grey,
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product.images[index],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(height: 10),
                      TextWidget(
                          text: product.title,
                          color: AppColors.dark,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          size: 28,
                          fontWeight: FontWeight.bold),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const TextWidget(
                            text: 'Category: ',
                            size: 15.5,
                            color: AppColors.dark,
                          ),
                          TextWidget(
                            text: product.category[0].toUpperCase() +
                                product.category.substring(1),
                            size: 16,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          productdetailinfo(
                            product.rating.toString(),
                            const Icon(EneftyIcons.star_bold,
                                color: Color(0xFFE8BE05), size: 20),
                          ),
                          const SizedBox(width: 10),
                          productdetailinfo(
                            product.stock.toString(),
                            const Icon(EneftyIcons.box_outline,
                                color: AppColors.primary, size: 20),
                          ),
                          const SizedBox(width: 10),
                          productdetailinfo(
                            product.brand,
                            const Icon(EneftyIcons.a_3_square_bold,
                                color: Color(0xFF2C04CD), size: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextWidget(
                          text: product.description,
                          size: 17.5,
                          maxLines: 6,
                          color: const Color(0xFF717171)),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomSheet: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: AppColors.grey,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    text: 'Price:',
                    size: 16,
                    color: AppColors.dark,
                    fontWeight: FontWeight.normal,
                  ),
                  TextWidget(
                    text: '\$${product.price}',
                    size: 30,
                    color: AppColors.dark,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              ButtonWidget(
                width: 0.63,
                text: 'Add to Cart',
                fontWeight: FontWeight.w600,
                onPressed: () {
                  context.read<StoreBloc>().add(ProductAddedToCart(product.id));

                  if (!inCart) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(_buildSnackBar('Product added to cart'));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        _buildSnackBar('Product already in cart'));
                  }
                },
                color: AppColors.primary,
                textColor: AppColors.light,
              ),
            ],
          ),
        ),
      );
    },
  );
}
