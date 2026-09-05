import 'dart:io';

import 'package:ecommerce/controllers/profile/profile_controller.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:ecommerce/view/widget/searchdelegate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Usergreetingbar extends StatelessWidget {
  const Usergreetingbar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ProfileControllerImpl>()
        ? Get.find<ProfileControllerImpl>()
        : Get.put(ProfileControllerImpl());

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 12, right: 14),
          child: GestureDetector(
            onTap: () => Get.toNamed(approute.editProfile),
            child: Obx(
              () => Hero(
                tag: 'profile-avatar',
                child: CircleAvatar(
                  radius: 35,
                  backgroundColor: const Color(0xFFE8F0FF),
                  backgroundImage: controller.profileImageUrl.value.isNotEmpty
                      ? (controller.profileImageUrl.value.startsWith('http')
                            ? NetworkImage(controller.profileImageUrl.value)
                            : FileImage(File(controller.profileImageUrl.value)))
                      : null,
                  child: controller.profileImageUrl.value.isEmpty
                      ? const Icon(
                          Icons.person,
                          size: 30,
                          color: Color(0xFF2563EB),
                        )
                      : null,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 2),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Text(
                'Hi, ibrahem',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              Text(
                "Let's go shopping",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
        SizedBox(width: 60),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
              ),
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.notifications_outlined),
                    onPressed: () {
                      Get.toNamed(approute.notifications);
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
