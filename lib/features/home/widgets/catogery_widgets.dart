import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gadgets_marketplace/core/constants/app_button_styles.dart';
import 'package:gadgets_marketplace/core/constants/app_colors.dart';
import 'package:gadgets_marketplace/core/constants/app_text_styles.dart';
import 'package:gadgets_marketplace/core/widgets/common.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_bloc.dart';
import 'package:gadgets_marketplace/features/home/bloc/product_filter_event.dart';
import 'package:gadgets_marketplace/features/home/cubit/update_index_cubit.dart';

class CategoryWidgets extends StatefulWidget {
  const CategoryWidgets({super.key});

  @override
  State<CategoryWidgets> createState() => _CategoryWidgetsState();
}

class _CategoryWidgetsState extends State<CategoryWidgets> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateIndexCubit, int>(
      builder: (context, currentIndex) {
        return SizedBox(
          height: 65,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              bool isSelected = currentIndex == index;

              if (Common.catogeries[index]['name'] == "All") {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<UpdateIndexCubit>().updateIndex(index);
                      context.read<ProductFilterBloc>().add(
                        FetchProductEvent(
                          filter: ProductFilter(
                            category: Common.catogeries[index]['name'],
                          ),
                        ),
                      );
                    },

                    style: isSelected
                        ? AppButtonStyles.primaryButtonStyle
                        : AppButtonStyles.secondaryButtonStyle,
                    // style: ButtonStyle(
                    //   backgroundColor: WidgetStatePropertyAll(
                    //     isSelected ? AppColors.primary : AppColors.border1,
                    //   ),
                    //   shape: WidgetStatePropertyAll(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadiusGeometry.circular(20),
                    //       side: BorderSide(color: AppColors.primary),
                    //     ),
                    //   ),
                    //   elevation: WidgetStatePropertyAll(0.5),
                    // ),
                    child: Text(
                      Common.catogeries[index]['name'],
                      style: isSelected
                          ? AppTextStyles.button
                          : AppTextStyles.bodySmall,
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<UpdateIndexCubit>().updateIndex(index);
                      context.read<ProductFilterBloc>().add(
                        FetchProductEvent(
                          filter: ProductFilter(
                            category: Common.catogeries[index]['name'],
                          ),
                        ),
                      );
                    },
                    style: isSelected
                        ? AppButtonStyles.primaryButtonStyle
                        : AppButtonStyles.secondaryButtonStyle,
                    // style: ButtonStyle(
                    //   backgroundColor: WidgetStatePropertyAll(
                    //     isSelected ? AppColors.primary : AppColors.border1,
                    //   ),
                    //   shape: WidgetStatePropertyAll(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadiusGeometry.circular(20),
                    //       side: BorderSide(color: AppColors.primary),
                    //     ),
                    //   ),
                    //   elevation: WidgetStatePropertyAll(0.5),
                    // ),
                    label: Text(
                      Common.catogeries[index]['name'],
                      style: isSelected
                          ? AppTextStyles.button
                          : AppTextStyles.bodySmall,
                    ),
                    icon: Icon(
                      Common.catogeries[index]['icon'],
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                );
              }
            },
            itemCount: Common.catogeries.length,
          ),
        );
      },
    );
  }
}
