import 'package:ecommerce/core/constants/colore.dart';
import 'package:ecommerce/view/approute.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingItems = [
      _SettingItem(
        icon: Icons.person_outline,
        title: 'Edit Profile',
        onTap: () => Get.toNamed(approute.editProfile),
      ),
      _SettingItem(
        icon: Icons.lock_outline,
        title: 'Change Password',
        onTap: () => Get.toNamed(approute.changePassword),
      ),
      _SettingItem(
        icon: Icons.notifications_none,
        title: 'Notifications',
        onTap: () => Get.toNamed(approute.notifications),
      ),
      _SettingItem(
        icon: Icons.shield_outlined,
        title: 'Security',
        onTap: () => Get.snackbar('Security', 'Security settings coming soon'),
      ),
      _SettingItem(
        icon: Icons.language_outlined,
        title: 'Language',
        trailing: 'English',
        onTap: () => Get.toNamed(approute.language),
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.black,
          ),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert, color: AppColors.black),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          children: [
            const SizedBox(height: 8),
            ...settingItems.map((item) => _SettingsCard(item: item)),
            const SizedBox(height: 18),
            const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12),
            _SettingsCard(
              item: _SettingItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Legal and Policies',
                onTap: () => Get.snackbar('Policies', 'Legal page coming soon'),
              ),
            ),
            _SettingsCard(
              item: _SettingItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () =>
                    Get.snackbar('Support', 'Support page coming soon'),
              ),
            ),
            const SizedBox(height: 12),
            _LogoutRow(),
          ],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.item});

  final _SettingItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey.withOpacity(0.18)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.primaryPale,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(item.icon, color: AppColors.primary, size: 20),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        trailing: item.trailing != null
            ? Text(
                item.trailing!,
                style: const TextStyle(fontSize: 14, color: AppColors.grey),
              )
            : const Icon(Icons.chevron_right, color: AppColors.black, size: 24),
        onTap: item.onTap,
      ),
    );
  }
}

class _LogoutRow extends StatelessWidget {
  const _LogoutRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.grey.withOpacity(0.18)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE7E7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.logout, color: Color(0xFFEF4444), size: 20),
        ),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFFEF4444),
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Color(0xFFEF4444),
          size: 22,
        ),
        onTap: () {
          Get.defaultDialog(
            title: 'Logout',
            middleText: 'Are you sure you want to logout?',
            textCancel: 'Cancel',
            textConfirm: 'Logout',
            confirmTextColor: AppColors.white,
            buttonColor: AppColors.primary,
            onConfirm: () => Get.offAllNamed(approute.login),
          );
        },
      ),
    );
  }
}

class _SettingItem {
  const _SettingItem({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;
}
