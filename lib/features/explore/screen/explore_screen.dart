import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:gadgets_marketplace/core/routes/app_router.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_bloc.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_event.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_state.dart';
import 'package:gadgets_marketplace/features/home/cubit/bottom_nav_cubit.dart';
import 'package:gadgets_marketplace/features/home/widgets/app_bar_widget.dart';
import 'package:gadgets_marketplace/features/home/widgets/catogery_widgets.dart';
import 'package:gadgets_marketplace/features/home/widgets/product_card.dart';

import '../../home/cubit/search_header_cubit.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ScrollController _scrollController = ScrollController();
  final _searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.clear();

    _scrollController.addListener(
      () => context.read<SearchHeaderCubit>().updateShowAppbarSearchIcon(
        _scrollController.offset,
      ),
    );
    context.read<BottomNavCubit>().updateNavIndex(0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.background2,
      body: Padding(
        padding: EdgeInsetsGeometry.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 8,
        ),
        child: SafeArea(
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              AppBarWidget(
                onPressedSearchIcon: () {
                  if (searchController.text.isNotEmpty) {
                    context.read<ProductFilterBloc>().add(
                      FetchProductEvent(
                        filter: ProductFilter(keyword: searchController.text),
                      ),
                    );
                  }
                },
                onTapSearchbar: () {
                  searchController.clear();
                  if (_searchFocusNode.canRequestFocus) {
                    _searchFocusNode.requestFocus();
                  }
                  // context.read<BottomNavCubit>().updateNavIndex(1);
                },

                onTapAppBarSearchIcon: () {
                  if (searchController.text.isNotEmpty) {
                    context
                        .read<SearchHeaderCubit>()
                        .updateShowAppbarSearchIcon(0);
                    if (_searchFocusNode.canRequestFocus) {
                      _searchFocusNode.requestFocus();
                    }

                    context.read<ProductFilterBloc>().add(
                      FetchProductEvent(
                        filter: ProductFilter(keyword: searchController.text),
                      ),
                    );
                  }
                },
                formKey: formKey,
                searchFocusNode: _searchFocusNode,
                title: "Explore",
                isShowNotiIcon: false,
                searchController: searchController,
              ),

              SliverToBoxAdapter(child: CategoryWidgets()),
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
                        child: Text(
                          state.message,
                          style: AppTextStyles.caption,
                        ),
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
                            AppRouter.router.push('/details/${product.id}');
                          },
                        );
                      },
                    );
                  }
                  return SliverToBoxAdapter(child: const SizedBox.shrink());
                },
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}
