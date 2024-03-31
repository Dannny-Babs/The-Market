import '../utils/bloc.dart';
import '../utils/packages.dart';
import '../utils/screens.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        title: const TextWidget(
          text: 'Search',
          size: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.dark,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              SearchBarWidget(
                  hintText: 'Search',
                  onChanged: (value) {
                    context.read<StoreBloc>().add(ProductSearch(value));
                  }),
              SizedBox(height: 20),
              BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  if (state.productStatus == StoreRequest.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.productStatus == StoreRequest.error) {
                    return const Center(
                        child: TextWidget(text: 'An error occurred'));
                  } else if (state.productStatus == StoreRequest.success) {
                    return Column(
                      children: state.products.map((product) {
                        return ProductCard(
                            product: product,
                            onPressed: () {
                              MaterialPageRoute(
                                builder: (context) => ProductScreen(
                                  productID: product.id,
                                ),
                              );
                            });
                      }).toList(),
                    );
                  } else {
                    return const Center(
                        child: TextWidget(text: 'No products found'));
                  }
                },
              ),
            ],
          )),
    );
  }
}
