import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sneaker_shop/data/config/service/local_service_client.dart';
import 'package:sneaker_shop/presentation/cart/bloc/cart/cart_cubit.dart';
import 'package:sneaker_shop/presentation/products/bloc/shoes/shoes_cubit.dart';
import 'package:sneaker_shop/presentation/products/widget/text_widget.dart';
import 'package:sneaker_shop/utils/resource/image_path.dart';
import 'package:sneaker_shop/utils/style/base_text_style.dart';

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
    print('check');
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                              return SizedBox(
                                height: screenHeight,
                                width: screenWidth,
                                child: Column(
                                  children: [
                                    TextWidget.title(
                                  text: cart.shoe.name,
                                ),
                                  ],
                                ),
                              );
                            })
                        : Text('No data');
                  }
                  return ListView.builder(itemBuilder: (context, index) {});
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
