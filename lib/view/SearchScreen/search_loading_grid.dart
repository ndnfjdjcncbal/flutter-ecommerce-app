import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchLoadingGrid extends StatelessWidget {
  const SearchLoadingGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 14,
          childAspectRatio: 0.68,
        ),
        itemBuilder: (context, index) => const _SearchLoadingCard(),
      ),
    );
  }
}

class _SearchLoadingCard extends StatelessWidget {
  const _SearchLoadingCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Bone(
            width: double.infinity,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        const SizedBox(height: 9),
        const Bone.text(words: 2),
        const SizedBox(height: 7),
        const Bone.text(words: 1),
        const SizedBox(height: 7),
        const Bone.text(words: 1),
      ],
    );
  }
}
