import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sneaker_shop/domain/entity/cart.dart';
import 'package:sneaker_shop/domain/entity/shoe.dart';
import 'package:sneaker_shop/presentation/products/bloc/shoes/shoes_cubit.dart';
import 'package:sneaker_shop/presentation/products/bloc/shoes_controller/shoes_controller_cubit.dart';
import 'package:sneaker_shop/presentation/widget/button_widget.dart';
import 'package:sneaker_shop/presentation/widget/text_widget.dart';
import 'package:sneaker_shop/utils/resource/image_path.dart';
import 'package:sneaker_shop/utils/style/base_text_style.dart';

class ShoesPage extends StatefulWidget {
  const ShoesPage({super.key});

  @override
  State<ShoesPage> createState() => _ShoesPageState();
}

class _ShoesPageState extends State<ShoesPage> {
  final ScrollController scrollController = ScrollController();
  List<Cart> cartItems = [];

  @override
  void initState() {
    super.initState();
    GetIt.instance.get<ShoesCubit>().getShoe();
    GetIt.instance.get<ShoesControllerCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildHeader(), _buildBody()],
        ),
      ),
    );
  }

  Expanded _buildBody() {
    return Expanded(
      child: BlocBuilder<ShoesCubit, ShoesState>(
        bloc: GetIt.instance.get<ShoesCubit>(),
        builder: (context, state) {
          if (state is ShoesSuccess) {
            final shoes = state.shoes;
            return ListView.builder(
                controller: scrollController,
                itemCount: shoes.length,
                itemBuilder: (context, index) {
                  final shoe = shoes[index];
                  return Padding(
                    padding: (index != 0)
                        ? const EdgeInsets.only(top: 64.0)
                        : EdgeInsets.zero,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: shoe.color,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Container(
                                  transformAlignment:
                                      AlignmentDirectional.center,
                                  transform: Matrix4.rotationZ(-0.4),
                                  child: CachedNetworkImage(
                                    key: UniqueKey(),
                                    imageUrl: shoe.image,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const CircularProgressIndicator(),
                                  )),
                            ),
                          ),
                          TextWidget.title(
                            text: shoe.name,
                          ),
                          TextWidget.description(
                            text: shoe.description,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget.title(
                                    text: "\$${shoe.price.toString()}"),
                                ButtonWidget.add(
                                  isSelected: shoe.isSelected,
                                  onTap: () {
                                    setState(() {
                                      shoe.isSelected = true;
                                      GetIt.instance
                                          .get<ShoesControllerCubit>()
                                          .addToCart(shoe: shoe);
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Column _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          ImagePath.nike,
          height: 80,
          width: 80,
        ),
        Text(
          'Our Products',
          style: TxtStyle.topic(),
        )
      ],
    );
  }

  bool isProductInCart({required Shoe shoe, required List<Cart> cartItems}) {
    for (var cartItem in cartItems) {
      if (cartItem.shoe.id == shoe.id) {
        return true; // Sản phẩm đã tồn tại trong giỏ hàng
      }
    }
    return false; // Sản phẩm chưa tồn tại trong giỏ hàng
  }
}
