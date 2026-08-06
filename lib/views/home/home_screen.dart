import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/cubits/bottom_nav_cubit.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/cubits/update_index_cubit.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/product_filter.dart';
import 'package:gadgets_marketplace/bloc/home/events/product_filter_event.dart';
import 'package:gadgets_marketplace/core/routes/app_router.dart';
import 'package:gadgets_marketplace/core/widgets/common.dart';
import 'package:gadgets_marketplace/views/home/widgets/catogery_widgets.dart';
import 'package:gadgets_marketplace/views/home/widgets/search_icon_widget.dart';

import '../../bloc/home/blocs/product_filter_bloc.dart';
import '../../bloc/home/states/product_filter_state.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final _searchFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // _scrollController.addListener(
    //   () => context.read<SearchHeaderCubit>().updateShowAppbarSearchIcon(
    //     _scrollController.offset,
    //   ),
    // );

    context.read<UpdateIndexCubit>().updateIndex(0);
    context.read<ProductFilterBloc>().add(
      FetchProductEvent(filter: ProductFilter()),
    );
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Padding(
        padding: EdgeInsetsGeometry.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 8,
        ),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.background,
              titleSpacing: 0,
              pinned: true,
              scrolledUnderElevation: 0,

              title: Text("Gadgets Marketplace", style: AppTextStyles.h2),
              actions: [
                SearchIconWidget(
                  onTap: () {
                    context.read<BottomNavCubit>().updateNavIndex(1);
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 8, bottom: 16),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border2),
                ),
                child: CarouselSlider(
                  items: Common.carouselItems,
                  options: CarouselOptions(
                    height: 150,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayAnimationDuration: Duration(milliseconds: 1000),
                    autoPlayCurve: Curves.linear,
                    enlargeCenterPage: true,
                    enlargeFactor: 0,
                    // onPageChanged: callbackFunction,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: AppTextStyles.h3.copyWith(color: AppColors.primary),
                  ),
                  Text(
                    "See all",
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: CategoryWidgets()),

            // SliverToBoxAdapter(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text("Trending Now", style: AppTextStyles.h3),
            //       Text(
            //         "See all",
            //         style: AppTextStyles.body.copyWith(
            //           color: AppColors.secondary,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Products Lists section
            BlocBuilder<ProductFilterBloc, ProductFilterState>(
              builder: (context, state) {
                if (state is ProductFilterLoadingState) {
                  return SliverToBoxAdapter(
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                if (state is ProductFilterErrorState) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(state.message, style: AppTextStyles.caption),
                    ),
                  );
                }

                if (state is ProductFilterSuccessState) {
                  if (state.products.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'No products available',
                          style: AppTextStyles.caption,
                        ),
                      ),
                    );
                  }

                  return SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          // Product Detail Screen သို့ သွားရန်
                          AppRouter.router.push('/details');
                        },
                      );
                    },
                  );
                }
                return SliverToBoxAdapter(child: const SizedBox.shrink());
              },
            ),
          ],
        ),
      ),
    );
  }
}
