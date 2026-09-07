import 'package:ecommerce/controllers/Home/homecontroller.dart';
import 'package:ecommerce/core/classes/handlingdataview.dart';
import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:ecommerce/core/constants/app_links/linkapi.dart';
import 'package:ecommerce/core/constants/app_links/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<HomeControllerImpl>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: GetBuilder<HomeControllerImpl>(
            builder: (controller) => Handlingdataview(
              statusRequest:
                  controller.categories.isEmpty &&
                      controller.statusRequestCategory == StatusRequest.none
                  ? StatusRequest.loading
                  : controller.statusRequestCategory,
              widget: CategoryContent(categories: controller.categories),
              widget1: const CategorySkeleton(),
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryContent extends StatelessWidget {
  final List<dynamic> categories;

  const CategoryContent({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: categories.length,
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        childAspectRatio: 3,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return CategoryTile(category: category);
      },
    );
  }
}

class CategoryTile extends StatelessWidget {
  final dynamic category;

  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryId = category['category_id']?.toString() ?? '';
    final categoryName = category['category_name']?.toString() ?? 'Category';
    final imageUrl = '${Linkapi.rimages}/${category['category_image']}';

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () {
        Get.toNamed(
          approute.getitems_forCategory,
          arguments: {'categoryId': categoryId, 'categoryName': categoryName},
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: SizedBox(
          height: 120,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade100,
                    child: const Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.62),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    categoryName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategorySkeleton extends StatelessWidget {
  const CategorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFFDDE3EA),
        highlightColor: Color(0xFFF7F9FB),
        duration: Duration(milliseconds: 1250),
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 2.95,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                const Bone(width: double.infinity, height: double.infinity),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Bone.text(
                      width: index.isEven ? 115 : 85,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
