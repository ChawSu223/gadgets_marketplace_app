import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_bloc.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_event.dart';
import 'package:gadgets_marketplace/features/home/widgets/notification_widget.dart';
import 'package:gadgets_marketplace/features/home/widgets/search_bar_widget.dart';
import 'package:gadgets_marketplace/features/home/widgets/search_icon_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../cubit/search_header_cubit.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({
    super.key,
    required this.formKey,
    required this.searchFocusNode,
    required this.title,
    this.isShowNotiIcon = true,
    required this.searchController,
    this.onTapAppBarSearchIcon,
    this.onTapSearchbar,
    this.onPressedSearchIcon,
  });

  final GlobalKey<FormState> formKey;
  final FocusNode searchFocusNode;
  final String title;
  final bool isShowNotiIcon;
  final TextEditingController searchController;
  void Function()? onTapAppBarSearchIcon;
  void Function()? onTapSearchbar;
  void Function()? onPressedSearchIcon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchHeaderCubit, SearchHeaderState>(
      builder: (context, state) {
        return SliverAppBar(
          expandedHeight: 110.0, // App Bar Height
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          backgroundColor: AppColors.background2,
          title: Text(
            title,
            style: AppTextStyles.title2,
            // textAlign: ,
          ),
          pinned:
              true, // Scroll ဘယ်လောက်လုပ်လုပ် App Bar ကို အပေါ်မှာ အမြဲ ကပ်ကျန်နေစေချင်ရင် true ထားပါ
          floating:
              false, // Scroll အပေါ်နည်းနည်းဆွဲတာနဲ့ App Bar ချက်ချင်း ပေါ်စေချင်ရင် true ထားပါ
          flexibleSpace: FlexibleSpaceBar(
            background: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SearchBarWidget(
                      onPressedSearhIcon: onPressedSearchIcon,
                      onFieldSubmitted: (value) {
                        context.read<ProductFilterBloc>().add(
                          FetchProductEvent(
                            filter: ProductFilter(keyword: value),
                          ),
                        );
                      },
                      onTap: onTapSearchbar,
                      formKey: formKey,
                      searchFocusNode: searchFocusNode,
                      searchController: searchController,
                    ),
                  ),
                ],
              ),
            ),
          ),

          actions: [
            if (isShowNotiIcon)
              NotificationWidget(
                count: 1,
                onPressed: () {},
                iconData: LucideIcons.bell,
              )
            else
              Container(),
            if (state.showAppbarSearchIcon)
              SearchIconWidget(onTap: onTapAppBarSearchIcon),
          ],
        );
      },
    );
  }
}
