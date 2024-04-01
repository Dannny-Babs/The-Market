
import '../utils/bloc.dart';
import '../utils/packages.dart';
import '../utils/screens.dart';

class SearchScreen extends StatefulWidget {
  final String searchquery;
  const SearchScreen({super.key, this.searchquery = ''});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SearchBarWidget(
                hintText: 'Search',
                onSubmitted: (value) {
                  value = widget.searchquery + value;
                  context.read<StoreBloc>().add(ProductSearch(value));
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  if (state.productStatus == StoreRequest.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.productStatus == StoreRequest.error) {
                    return const Center(
                        child: TextWidget(text: 'An error occurred'));
                  } else if (state.productStatus == StoreRequest.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Search results: ${state.products.length}',
                          size: 17,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF9C9C9C),
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCard(
                              product: product,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductScreen(productID: product.id),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
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

class SearchScreen2 extends StatefulWidget {
  final String searchquery;
  const SearchScreen2({super.key, this.searchquery = ''});

  @override
  State<SearchScreen2> createState() => _SearchScreen2State();
}

class _SearchScreen2State extends State<SearchScreen2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: AppColors.dark),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              SearchBarWidget(
                hintText: 'Search',
                onSubmitted: (value) {
                  value = widget.searchquery + value;
                  context.read<StoreBloc>().add(ProductSearch(value));
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<StoreBloc, StoreState>(
                builder: (context, state) {
                  if (state.productStatus == StoreRequest.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.productStatus == StoreRequest.error) {
                    return const Center(
                        child: TextWidget(text: 'An error occurred'));
                  } else if (state.productStatus == StoreRequest.success) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Search results: ${state.products.length}',
                          size: 17,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF9C9C9C),
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.products.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return ProductCard(
                              product: product,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProductScreen(productID: product.id),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
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
