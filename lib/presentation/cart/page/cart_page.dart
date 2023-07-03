import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';
import 'package:sneaker_shop/presentation/cart/bloc/cart/cart_cubit.dart';
import 'package:sneaker_shop/presentation/cart/bloc/cart_controller/cart_controller_cubit.dart';
import 'package:sneaker_shop/presentation/widget/button_widget.dart';
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
    GetIt.instance.get<CartControllerCubit>().stream.listen((state) {
      if (state is CartControllerSuccess) {
        GetIt.instance.get<CartCubit>().clean();
        GetIt.instance.get<CartCubit>().getCart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: BlocBuilder<CartCubit, CartState>(
          bloc: GetIt.instance.get<CartCubit>(),
          builder: (context, state) {
            if (state is CartSuccess) {
              final carts = state.cart;
              final total = state.totalPrice;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(total),
                  _buildBody(carts),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Expanded _buildBody(List<Cart> carts) {
    return Expanded(
        child: (carts.isNotEmpty)
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
                            child:
                                Stack(alignment: Alignment.center, children: [
                              CircleAvatar(
                                backgroundColor: ColorHelper.getColorFromString(
                                    cart.shoe.color),
                                radius: 35,
                              ),
                              Container(
                                  transformAlignment:
                                      AlignmentDirectional.center,
                                  transform: Matrix4.rotationZ(-0.5),
                                  child: CachedNetworkImage(
                                    key: UniqueKey(),
                                    imageUrl: cart.shoe.image,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const CircularProgressIndicator(),
                                  )),
                            ]),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  cart.shoe.name,
                                  style: TxtStyle.title(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                Text(
                                  "\$${cart.shoe.price.toString()}",
                                  style: TxtStyle.title(fontSize: 20),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ButtonWidget.icon(
                                            onTap: () {
                                              GetIt.instance
                                                  .get<CartControllerCubit>()
                                                  .deCreaseCart(cart: cart);
                                            },
                                            icon: ImagePath.minus,
                                            color: BaseColor.grey,
                                            radius: radiusIcon),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Text(
                                            cart.quantity.toString(),
                                            style: TxtStyle.title(fontSize: 16),
                                          ),
                                        ),
                                        ButtonWidget.icon(
                                            onTap: () {
                                              GetIt.instance
                                                  .get<CartControllerCubit>()
                                                  .inCreaseCart(cart: cart);
                                            },
                                            icon: ImagePath.plus,
                                            color: BaseColor.grey,
                                            radius: radiusIcon),
                                      ],
                                    ),
                                    ButtonWidget.icon(
                                        onTap: () {
                                          GetIt.instance
                                              .get<CartControllerCubit>()
                                              .removeCart(cart: cart);
                                        },
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
            : Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  'Your cart is empty.',
                  style: TxtStyle.description(),
                ),
              ));
  }

  Column _buildHeader(double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          ImagePath.nike,
          height: 80,
          width: 80,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Our Cart',
              style: TxtStyle.topic(),
            ),
            Text(
              "\$${total.toStringAsFixed(2)}",
              style: TxtStyle.topic(),
            ),
          ],
        )
      ],
    );
  }
}
