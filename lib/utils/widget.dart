import 'package:the_market/utils/bloc.dart';
import 'package:the_market/utils/packages.dart';
import 'package:the_market/utils/screens.dart';

import '../data/models/products.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final double spacing;

  const TextWidget({
    Key? key,
    required this.text,
    this.color = AppColors.dark,
    this.size = 16,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.spacing = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        letterSpacing: spacing,
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final Function(String) onSubmitted;

  const SearchBarWidget({
    Key? key,
    required this.hintText,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                onSubmitted(value);
              },
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.dark,
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: GoogleFonts.plusJakartaSans(
                    color: const Color(0xFF7C7C7C),
                    fontSize: 17.5,
                    fontWeight: FontWeight.w500),
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(
            EneftyIcons.search_normal_outline,
            color: AppColors.dark,
          )
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color = AppColors.primary,
      this.textColor = AppColors.light,
      this.size = 20,
      this.fontWeight = FontWeight.w500,
      this.width = 0.8,
      this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      this.borderRadius = 16});

  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final double size;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final double width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        width: MediaQuery.of(context).size.width * width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: TextWidget(
          text: text,
          color: textColor,
          size: size,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: const Color(0xFFCECECE),
            highlightColor: const Color(0xFFE9E9E9),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: AppColors.grey,
            highlightColor: AppColors.light,
            child: Container(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Shimmer.fromColors(
            baseColor: AppColors.grey,
            highlightColor: AppColors.light,
            child: Container(
              height: 20,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key, required this.product, required this.onPressed});
  final Products product;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        key: ValueKey(product.id),
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.grey,
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                product.image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Text(
                  product.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF949494),
                  ),
                  textWidthBasis: TextWidthBasis.parent,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    EneftyIcons.star_bold,
                    color: Color(0xFFFCC00C),
                    size: 16,
                  ),
                  const SizedBox(width: 3),
                  TextWidget(
                    text: product.rating.toString(),
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 5),
          TextWidget(
            text: '\$${product.price}',
            size: 22,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

Widget productdetailinfo(String detail, Icon icon) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(
        color: AppColors.grey,
        width: 1,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: 8),
        TextWidget(
          text: detail,
          size: 17,
          fontWeight: FontWeight.w600,
          color: AppColors.dark,
        ),
      ],
    ),
  );
}

class CartProductCard extends StatefulWidget {
  const CartProductCard({super.key, required this.product});
  final Products product;

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  @override
  Widget build(BuildContext context) {
    int totalPrice = widget.product.price * widget.product.quantity;
    int quantity = widget.product.quantity;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(
                    productID: widget.product.id,
                  ),
                ),
              );
            },
            child: Container(
                height: 150,
                width: 150,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.fitHeight,
                  ),
                )),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: widget.product.title,
                          size: 20,
                          fontWeight: FontWeight.w700,
                        ),
                        const SizedBox(height: 5),
                        TextWidget(
                          text: widget.product.brand,
                          size: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF8A8A8A),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () {
                        context
                            .read<StoreBloc>()
                            .add(ProductRemovedFromCart(widget.product.id));
                      },
                      child: const Icon(
                        EneftyIcons.close_outline,
                        color: Color(0xFF691D18),
                        size: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: '\$${totalPrice.toString()}',
                      size: 28,
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                              });
                              context.read<StoreBloc>().add(
                                  UpdateProductQuantity(
                                      widget.product.id.toString(), quantity));
                            }
                          },
                          icon: const Icon(EneftyIcons.minus_square_outline,
                              size: 32),
                        ),
                        const SizedBox(width: 8),
                        TextWidget(
                          text: quantity.toString(),
                          size: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantity++;
                            });
                            context.read<StoreBloc>().add(UpdateProductQuantity(
                                widget.product.id.toString(), quantity));

                          },
                          icon: const Icon(EneftyIcons.add_square_outline,
                              size: 32, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
