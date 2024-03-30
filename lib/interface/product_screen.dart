import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';

class ProductScreen extends StatefulWidget {
  final int productID;
  const ProductScreen({
    super.key,
    this.productID = 0,
  });

  @override
  _ProductScreenState createState() => _ProductScreenState();
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
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.productStatus == StoreRequest.success) {
          final product = state.product;
          print(product);
          return Container();
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }
}
