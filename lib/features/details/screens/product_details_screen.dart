import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/core/constants/app_button_styles.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:gadgets_marketplace/core/routes/app_router.dart';
import 'package:gadgets_marketplace/core/widgets/network_image_frame.dart';
import 'package:gadgets_marketplace/features/cart/bloc/cart_item_bloc.dart';
import 'package:gadgets_marketplace/features/cart/bloc/cart_item_event.dart';
import 'package:gadgets_marketplace/features/cart/bloc/cart_item_state.dart';
import 'package:gadgets_marketplace/features/details/bloc/product_detail_bloc.dart';
import 'package:gadgets_marketplace/features/details/bloc/product_detail_event.dart';
import 'package:gadgets_marketplace/features/details/bloc/product_detail_state.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_bloc.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_event.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_state.dart';
import 'package:gadgets_marketplace/features/home/cubit/bottom_nav_cubit.dart';
import 'package:gadgets_marketplace/features/home/cubit/update_index_cubit.dart';
import 'package:gadgets_marketplace/features/home/widgets/notification_widget.dart';
import 'package:gadgets_marketplace/features/home/widgets/product_card.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final pageController = PageController(viewportFraction: 0.7);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductDetailBloc>().add(
      FetchProductByIdEvent(id: widget.productId),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        if (state is ProductDetailLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductDetailErrorState) {
          return Center(child: Text(state.message));
        }
        if (state is ProductDetailSuccessState) {
          context.read<ProductFilterBloc>().add(
            FetchProductEvent(
              filter: ProductFilter(category: state.product.category),
            ),
          );
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              title: Text(state.product.name),
              centerTitle: true,
              leading: IconButton(
                onPressed: () {
                  AppRouter.router.pop();
                },
                icon: Icon(CupertinoIcons.back, size: 28),
              ),
              actions: [
                BlocBuilder<CartItemBloc, CartItemState>(
                  builder: (context, state) {
                    return NotificationWidget(
                      count: state.cartItems.length,
                      onPressed: () {
                        context.read<BottomNavCubit>().updateNavIndex(3);
                        while (context.canPop()) {
                          context.pop();
                        }
                      },
                      iconData: LucideIcons.shoppingCart,
                    );
                  },
                ),
              ],
            ),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 260,
                  width: double.infinity,

                  child: PageView.builder(
                    controller: pageController,
                    itemBuilder: (_, index) {
                      return NetworkImageFrame(
                        margin: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        imagePath: state.product.imageUrl,
                      );
                    },
                    itemCount: 3,
                  ),
                ),
                Center(
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ScrollingDotsEffect(
                      activeStrokeWidth: 2.6,
                      activeDotScale: 1.3,
                      maxVisibleDots: 5,
                      radius: 8,
                      spacing: 10,
                      dotHeight: 9,
                      dotWidth: 9,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  // height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text("Select Variant", style: AppTextStyles.h2),
                      ),
                      Text("Color", style: AppTextStyles.h2),
                      BlocProvider<UpdateIndexCubit>(
                        create: (context) => UpdateIndexCubit(),
                        child: BlocBuilder<UpdateIndexCubit, int>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 16,
                              ),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<UpdateIndexCubit>()
                                          .updateIndex(0);
                                    },
                                    style: state == 0
                                        ? AppButtonStyles.primaryButtonStyle
                                        : AppButtonStyles.secondaryButtonStyle,
                                    child: Text(
                                      "Midnight",
                                      style: state == 0
                                          ? AppTextStyles.button
                                          : AppTextStyles.bodySmall,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<UpdateIndexCubit>()
                                          .updateIndex(1);
                                    },
                                    style: state == 1
                                        ? AppButtonStyles.primaryButtonStyle
                                        : AppButtonStyles.secondaryButtonStyle,
                                    child: Text(
                                      "Starlight",
                                      style: state == 1
                                          ? AppTextStyles.button
                                          : AppTextStyles.bodySmall,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Divider(),
                      ExpansionTile(
                        tilePadding: EdgeInsets.all(0),
                        childrenPadding: EdgeInsets.only(top: 8, bottom: 16),

                        dense: true,
                        minTileHeight: 40,
                        title: Text("Description", style: AppTextStyles.h2),
                        children: [
                          Text(
                            state.product.description,
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ExpansionTile(
                        childrenPadding: EdgeInsets.only(top: 8, bottom: 16),
                        tilePadding: EdgeInsets.all(0),
                        dense: true,
                        minTileHeight: 40,
                        title: Text("Specifications", style: AppTextStyles.h2),

                        // children: [
                        //   Text(
                        //     "${state.product.specs.keys.toString()} : ${state.product.specs.values.toString()}",
                        //     style: AppTextStyles.body,
                        //   ),
                        // ],
                        expandedAlignment: Alignment.centerLeft,
                        children: state.product.specs.entries
                            .map(
                              (e) => Text(
                                "${e.key} : ${e.value}",
                                style: AppTextStyles.body,
                              ),
                            )
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CartItemBloc>().add(
                              AddToCartEvent(
                                productModel: state.product,
                                quantity: 1,
                              ),
                            );
                          },
                          style: AppButtonStyles.fullButtonStyle,
                          child: Text(
                            "Add to Cart",
                            style: AppTextStyles.button.copyWith(fontSize: 18),
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        height: 220,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                "Related products",
                                style: AppTextStyles.h2.copyWith(fontSize: 16),
                              ),
                            ),
                            BlocBuilder<ProductFilterBloc, ProductFilterState>(
                              builder: (_, state) {
                                if (state is ProductFilterLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state is ProductFilterErrorState) {
                                  return Center(
                                    child: Text(
                                      state.message,
                                      style: TextStyle(color: AppColors.error),
                                    ),
                                  );
                                }
                                if (state is ProductFilterSuccessState) {
                                  return SizedBox(
                                    height: 150,
                                    child: GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                          ),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8,
                                          ),
                                          child: ProductCard(
                                            product: state.products[index],
                                            onTap: () {
                                              AppRouter.router.push(
                                                "/details/${state.products[index].id}",
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      itemCount: state.products.length,
                                    ),
                                  );
                                }
                                return SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  // List<Color> colors = [
  //   AppColors.primary,
  //   AppColors.textPrimary,
  //   AppColors.textSecondary,
  // ];
}
