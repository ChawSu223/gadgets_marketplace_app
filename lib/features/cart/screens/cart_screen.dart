import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/core/constants/app_button_styles.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:gadgets_marketplace/core/widgets/network_image_frame.dart';
import 'package:gadgets_marketplace/features/cart/bloc/cart_item_bloc.dart';
import 'package:gadgets_marketplace/features/cart/bloc/cart_item_event.dart';
import 'package:gadgets_marketplace/features/cart/bloc/cart_item_state.dart';
import 'package:gadgets_marketplace/features/cart/repositories/cart_item_repositories.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartItemRepo = CartItemRepositories();

  @override
  void initState() {
    super.initState();
    print("🔥 CART SCREEN INIT");
    context.read<CartItemBloc>().add(FetchCartItemsEvent());

    // context.watch<CartItemBloc>().state;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: Icon(CupertinoIcons.back),
          title: Text("Cart"),
        ),
        body: BlocListener<CartItemBloc, CartItemState>(
          listener: (context, state) {
            if (state is AddCartItemSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Added to cart"),
                  backgroundColor: AppColors.success,
                ),
              );
            }
            if (state is DeleteCartItemSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Successfully deleted this cart."),
                  backgroundColor: AppColors.success,
                ),
              );
            }
          },
          child: BlocBuilder<CartItemBloc, CartItemState>(
            builder: (context, state) {
              double totalPrice = 0;

              print("CART STATE = ${state.runtimeType}");

              if (state.cartItems.isEmpty) {
                return Center(
                  child: Text(
                    "There is no item in your cart!",
                    style: AppTextStyles.body,
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomScrollView(
                  slivers: [
                    SliverList.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (_, index) {
                        final item = state.cartItems[index];

                        totalPrice = cartItemRepo.getUnitItemTotalPrice(
                          item['product'].price,
                          item['quantity'],
                        );
                        return Container(
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.border1,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(8),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              NetworkImageFrame(
                                margin: EdgeInsets.only(right: 8),
                                imagePath: item['product'].imageUrl,
                                width: 80,
                                height: 80,
                                borderRadius: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                      item['product'].name,
                                      style: AppTextStyles.h3,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 4,
                                        bottom: 8,
                                      ),
                                      child: Text(
                                        "45mm Midnight",
                                        style: AppTextStyles.bodySmall,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          totalPrice.toStringAsFixed(2),
                                          style: AppTextStyles.h2,
                                        ),
                                        SizedBox(
                                          height: 25,
                                          width: 75,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    if (item['quantity'] >= 2) {
                                                      context
                                                          .read<CartItemBloc>()
                                                          .add(
                                                            UpdateQuantityEvent(
                                                              index: index,
                                                              qty:
                                                                  item['quantity'] -
                                                                  1,
                                                            ),
                                                          );
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.border2,
                                                      borderRadius:
                                                          BorderRadius.horizontal(
                                                            left:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                    ),
                                                    child: Icon(
                                                      LucideIcons.minus,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.symmetric(
                                                      horizontal: BorderSide(
                                                        color:
                                                            AppColors.border2,
                                                        width: 2,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    item['quantity'].toString(),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),

                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    if (item['quantity'] <=
                                                        19) {
                                                      context
                                                          .read<CartItemBloc>()
                                                          .add(
                                                            UpdateQuantityEvent(
                                                              index: index,
                                                              qty:
                                                                  item['quantity'] +
                                                                  1,
                                                            ),
                                                          );
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.border2,
                                                      borderRadius:
                                                          BorderRadius.horizontal(
                                                            right:
                                                                Radius.circular(
                                                                  10,
                                                                ),
                                                          ),
                                                    ),
                                                    child: Icon(
                                                      LucideIcons.plus,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    context.read<CartItemBloc>().add(
                                      DeleteCartItemsEvent(index: index),
                                    );
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SliverToBoxAdapter(
                      child: Divider(color: AppColors.border1, height: 32),
                    ),

                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Subtotal", style: AppTextStyles.body),
                              Text(
                                state.subTotal.toStringAsFixed(2),
                                // state.totalPrice.toStringAsFixed(2),
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Shipping estimate",
                                  style: AppTextStyles.body,
                                ),
                                Text(
                                  state.shippingCost!.toStringAsFixed(2),
                                  style: AppTextStyles.body,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tax", style: AppTextStyles.body),
                              Text(
                                state.tax!.toStringAsFixed(2),
                                style: AppTextStyles.body,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Total", style: AppTextStyles.body),
                                Text(
                                  cartItemRepo
                                      .getGrandTotalPrice(
                                        state.subTotal,
                                        state.shippingCost ?? 0,
                                        state.tax ?? 0,
                                      )
                                      .toStringAsFixed(2),
                                  style: AppTextStyles.body,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Divider(color: AppColors.border1, height: 32),
                    ),

                    SliverToBoxAdapter(
                      child: ElevatedButton(
                        style: AppButtonStyles.fullButtonStyle,
                        onPressed: () {},
                        child: Text("Check Out", style: AppTextStyles.button),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
