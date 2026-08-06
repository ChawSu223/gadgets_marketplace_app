import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/cubits/update_index_cubit.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/product_filter.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/product_filter_bloc.dart';
import 'package:gadgets_marketplace/bloc/home/events/product_filter_event.dart';
import 'package:gadgets_marketplace/bloc/home/states/product_filter_state.dart';
import 'package:gadgets_marketplace/core/constants/app_button_styles.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:gadgets_marketplace/core/routes/app_router.dart';
import 'package:gadgets_marketplace/core/widgets/common.dart';
import 'package:gadgets_marketplace/views/home/widgets/product_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final pageController = PageController(viewportFraction: 0.6);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductFilterBloc>().add(
      FetchProductEvent(filter: ProductFilter(category: 'All')),
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
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text("Product Details"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            AppRouter.router.pop();
          },
          icon: Icon(CupertinoIcons.back, size: 28),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 8),
            height: 260,
            width: double.infinity,
            // padding: EdgeInsetsGeometry.all(8),

            // child: CarouselSlider.builder(
            //   itemBuilder: (context, index, realIndex) {
            //     return Common.detailsCarouselItems[index];
            //   },
            //   itemCount: Common.detailsCarouselItems.length,
            //   options: CarouselOptions(
            //     aspectRatio: 4 / 3,
            //     viewportFraction: 0.7,
            //   ),
            // ),
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (_, index) {
                return Common.detailsCarouselItems[index];
              },
              itemCount: Common.detailsCarouselItems.length,
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: Common.detailsCarouselItems.length,
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
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                context.read<UpdateIndexCubit>().updateIndex(0);
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
                                context.read<UpdateIndexCubit>().updateIndex(1);
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
                  dense: true,
                  minTileHeight: 40,
                  title: Text("Features", style: AppTextStyles.h2),
                  children: [Text("data")],
                ),
                Divider(height: 0),
                ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  dense: true,
                  minTileHeight: 40,
                  title: Text("Features", style: AppTextStyles.h2),
                  children: [Text("data")],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {},
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
                            return Center(child: CircularProgressIndicator());
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
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ProductCard(
                                      product: state.products[index],
                                      onTap: () {
                                        AppRouter.router.push("/details");
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

  List<Color> colors = [
    AppColors.primary,
    AppColors.textPrimary,
    AppColors.textSecondary,
  ];
}
