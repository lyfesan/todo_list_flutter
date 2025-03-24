import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todo_list_flutter/providers/category_provider.dart';
import 'package:todo_list_flutter/utils/utils.dart';
import 'package:todo_list_flutter/widgets/widgets.dart';

class CategoriesSelection extends ConsumerWidget {
  const CategoriesSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(categoryProvider);
    final List<TaskCategory> categories = TaskCategory.values.toList();

    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: context.textTheme.titleMedium,
          ),
          const Gap(10),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ListView.separated(
                itemCount: categories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  final category = categories[index];

                  return InkWell(
                    onTap: () {
                      ref.read(categoryProvider.notifier).state = category;
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: CircleContainer(
                      color: category.color.withValues(alpha: 0.3),
                      child: Icon(
                        category.icon,
                        color: selectedCategory == category
                            ? context.colorScheme.primary
                            : category.color.withValues(alpha: 0.5),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Gap(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}