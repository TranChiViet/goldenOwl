import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sneaker_shop/presentation/products/bloc/shoes/shoes_cubit.dart';
import 'package:sneaker_shop/presentation/products/bloc/shoes_controller/shoes_controller_cubit.dart';
import 'package:sneaker_shop/presentation/products/widget/button_widget.dart';
import 'package:sneaker_shop/presentation/products/widget/text_widget.dart';
import 'package:sneaker_shop/utils/resource/image_path.dart';
import 'package:sneaker_shop/utils/style/base_text_style.dart';

class ShoesPage extends StatefulWidget {
  const ShoesPage({super.key});

  @override
  State<ShoesPage> createState() => _ShoesPageState();
}

class _ShoesPageState extends State<ShoesPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    GetIt.instance.get<ShoesCubit>().getShoe();
    GetIt.instance.get<ShoesControllerCubit>();
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
                  'Our Products',
                  style: TxtStyle.topic(),
                )
              ],
            ),
            Expanded(
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
                          return SizedBox(
                            height: screenHeight,
                            width: screenWidth,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: shoe.color,
                                        borderRadius: BorderRadius.circular(32)),
                                    child: Container(
                                      
                                        // transform: Matrix4.rotationZ(-0.4),
                                        child: Image.network(
                                          shoe.image,
                                          // height: screenHeight*0.4,
                                          // width: screenWidth*0.4,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${shoe.price.toString()}",
                                        style: TxtStyle.title(),
                                      ),
                                      ButtonWidget.add(onTap: () {
                                        GetIt.instance.get<ShoesControllerCubit>().addToCart(shoe: shoe);
                                      })
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        });
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
