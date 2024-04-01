import '../utils/packages.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget(
            text: 'Cart', size: 24.0, fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor: AppColors.light,
        iconTheme: const IconThemeData(color: AppColors.dark),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Text('Cart Screen'),
            ),
            ListView.builder(
                itemBuilder: (context, index) {
                  return const CartProductCard();
                },
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5),
          ],
        ),
      ),
    );
  }
}
