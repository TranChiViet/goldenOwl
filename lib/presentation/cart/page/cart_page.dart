import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sneaker_shop/presentation/cart/bloc/cart/cart_cubit.dart';
import 'package:sneaker_shop/presentation/products/widget/button_widget.dart';
import 'package:sneaker_shop/presentation/products/widget/text_widget.dart';
import 'package:sneaker_shop/utils/helper/color_helper.dart';
import 'package:sneaker_shop/utils/resource/image_path.dart';
import 'package:sneaker_shop/utils/style/base_color.dart';
import 'package:sneaker_shop/utils/style/base_text_style.dart';

const double radiusIcon = 30;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    GetIt.instance.get<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
            left: 16,
            right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImagePath.nike,
                  height: 80,
                  width: 80,
                ),
                Text(
                  'Our Cart',
                  style: TxtStyle.topic(),
                )
              ],
            ),
            Expanded(
              child: BlocBuilder<CartCubit, CartState>(
                bloc: GetIt.instance.get<CartCubit>(),
                builder: (context, state) {
                  if (state is CartSuccess) {
                    final carts = state.cart;
                    return (carts.isNotEmpty)
                        ? ListView.builder(
                            controller: scrollController,
                            itemCount: carts.length,
                            itemBuilder: (context, index) {
                              final cart = carts[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: SizedBox(
                                  height: 120,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: 
                                                // BaseColor.grey,

                                                ColorHelper.getColorFromString(cart.shoe.color),
                                                radius: 50,
                                              ),
                                              Container(
                                                  transformAlignment:
                                                      AlignmentDirectional.center,
                                                  transform:
                                                      Matrix4.rotationZ(-0.4),
                                                  child: Image.network(
                                                    cart.shoe.image,
                                                  )),
                                            ]),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              cart.shoe.name,
                                              style: TxtStyle.title(fontSize: 16),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                            Text(
                                              "\$${cart.shoe.price.toString()}",
                                              style: TxtStyle.title(fontSize: 16),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ButtonWidget.icon(
                                                        onTap: () {},
                                                        icon: ImagePath.minus,
                                                        color: BaseColor.grey,
                                                        radius: radiusIcon),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16.0),
                                                      child: Text(
                                                        cart.quantity.toString(),
                                                        style: TxtStyle.title(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    ButtonWidget.icon(
                                                        onTap: () {},
                                                        icon: ImagePath.plus,
                                                        color: BaseColor.grey,
                                                        radius: radiusIcon),
                                                  ],
                                                ),
                                                ButtonWidget.icon(
                                                    onTap: () {},
                                                    icon: ImagePath.trash,
                                                    color: BaseColor.yellow,
                                                    radius: radiusIcon),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            })
                        : const Text('Your cart is empty.');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
