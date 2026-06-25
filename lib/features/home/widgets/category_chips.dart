import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oravco_assignment/core/constants/app_colors.dart';
import 'package:oravco_assignment/core/constants/constants.dart';
import 'package:oravco_assignment/core/extension/theme_extension.dart';
import 'package:oravco_assignment/core/extension/string_extension.dart';
import 'package:oravco_assignment/features/home/view_model/home_screen_viewmodel.dart';

class CategoryChips extends ConsumerWidget {
  final List<String> categories;

  const CategoryChips({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final theme = context.theme;

    return SizedBox(
      height: 38.w,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;

          return Padding(
            padding: const EdgeInsets.only(right: padding),
            child: ChoiceChip(
              label: Text(
                category.capitalize,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? Colors.white
                      : theme.textTheme.bodyMedium?.color,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(selectedCategoryProvider.notifier).state = category;
                }
              },
              selectedColor: AppColors.primaryColor,
              backgroundColor: theme.colorScheme.surface,
              side: BorderSide(
                color: isSelected ? Colors.transparent : context.borderColor,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}
