import 'package:the_market/models/products.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state.productStatus == StoreRequest.unknown) {
          context.read<StoreBloc>().add(ProductRequested(widget.productID));
        }
        if (state.productStatus == StoreRequest.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.productStatus == StoreRequest.success) {
          print('success');
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
