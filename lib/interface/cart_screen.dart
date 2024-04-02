import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';

import '../data/models/products.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;

  double calculateTotalPrice(List<Products> products) {
    double totalPrice = 0.0;
    return totalPrice = products.fold(
        0.0,
        (previousValue, product) =>
            previousValue + (product.price * product.quantity));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
          text: 'Cart',
          size: 24.0,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.light,
        iconTheme: const IconThemeData(color: AppColors.dark),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: 'Cart Items',
              size: 20.0,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            BlocBuilder<StoreBloc, StoreState>(
              builder: (context, state) {
                if (state.productStatus == StoreRequest.unknown) {
                  context
                      .read<StoreBloc>()
                      .add(CategoryProductRequested('all'));
                }

                if (state.productStatus == StoreRequest.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.productStatus == StoreRequest.success) {
                  final productIds = state.cartIds;
                  final products = productIds
                      .map((id) => state.products
                          .firstWhere((product) => product.id == id))
                      .toList();

                  // Calculate total price and update quantity for each product

                  if (products.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        // Default quantity

                    

                        return CartProductCard(product: product);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('No products found'),
                    );
                  }
                } else if (state.productStatus == StoreRequest.error) {
                  return const Center(
                    child: Text('An error occurred'),
                  );
                }

                return const Center(
                  child: TextWidget(
                    text: 'No items in cart',
                    size: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.grey, width: 1),
          ),
        ),
        child: BottomAppBar(
          elevation: 0,
          color: AppColors.light,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<StoreBloc, StoreState>(
                  builder: (context, state) {
                    final productIds = state.cartIds;
                    final products = productIds
                        .map((id) => state.products
                            .firstWhere((product) => product.id == id))
                        .toList();

                    return TextWidget(
                      text: 'Total: \$${calculateTotalPrice(products)}',
                      size: 24.0,
                      fontWeight: FontWeight.bold,
                    );
                  },
                ),
                ButtonWidget(
                  onPressed: () {
                    // Add navigation to checkout screen
                  },
                  width: 0.38,
                  text: 'Checkout',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
