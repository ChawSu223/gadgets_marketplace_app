import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/product_filter.dart';
import 'package:gadgets_marketplace/bloc/home/blocs/product_filter_bloc.dart';
import 'package:gadgets_marketplace/bloc/home/events/product_filter_event.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SearchBarWidget extends StatefulWidget {
  SearchBarWidget({
    super.key,
    required this.formKey,
    required this.searchFocusNode,
    required this.searchController,
    this.onTap,
    this.onPressedSearhIcon,
    this.onFieldSubmitted,
  });

  final GlobalKey<FormState> formKey;
  final FocusNode searchFocusNode;
  final TextEditingController searchController;
  void Function()? onTap;
  void Function()? onPressedSearhIcon;
  void Function(String)? onFieldSubmitted;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        onTap: widget.onTap,
        focusNode: widget.searchFocusNode,
        onTapOutside: (event) {
          if (widget.searchFocusNode.hasFocus) {
            widget.searchFocusNode.unfocus();
          }
          context.read<ProductFilterBloc>().add(
            FetchProductEvent(
              filter: ProductFilter(keyword: widget.searchController.text),
            ),
          );
        },
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: widget.onPressedSearhIcon,
            icon: Icon(
              LucideIcons.search,
              size: 22,
              color: AppColors.textPrimary,
            ),
          ),
          hintText: "Search",
          hintStyle: AppTextStyles.body.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),

          fillColor: AppColors.border1,
          filled: true,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
