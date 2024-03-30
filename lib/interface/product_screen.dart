import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';

import '../models/products.dart';

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
  Widget build(BuildContext context) {
    return BlocBuilder<StoreBloc, StoreState>(
      builder: (context, state) {
        if (state.productStatus == StoreRequest.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.productStatus == StoreRequest.success) {
          final product = state.product
              .firstWhere((product) => product.id == widget.productID);
          return Scaffold(
            appBar: AppBar(
              title: Text(product.title),
            ),
            body: Column(
              children: [
                Image.network(product.thumbnail),
                Text(product.title),
                Text(product.description),
                Text(product.price.toString()),
              ],
            ),
          );
        }
        return const Center(
          child: Text('Error'),
        );
      },
    );
  }
}
