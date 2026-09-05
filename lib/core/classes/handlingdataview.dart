import 'package:ecommerce/core/classes/statusrequest.dart';
import 'package:flutter/material.dart';

class Handlingdataview extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  final Widget widget1;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  const Handlingdataview({
    required this.statusRequest,
    required this.widget,
    required this.widget1,
    this.onRetry,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return widget1;
    }

    if (statusRequest == StatusRequest.offlinefailure) {
      return _statusWidget(
        icon: Icons.wifi_off_rounded,
        title: "No Internet Connection",
        message: "Please check your internet connection and try again.",
        buttonText: "Try Again",
      );
    }

    if (statusRequest == StatusRequest.serverfailure) {
      return _statusWidget(
        icon: Icons.cloud_off_rounded,
        title: "Server Error",
        message:
            "Something went wrong with the server. Please try again later.",
        buttonText: "Try Again",
      );
    }

    if (statusRequest == StatusRequest.failure) {
      return _statusWidget(
        icon: Icons.inbox_rounded,
        title: "No Data Found",
        message: "There is no data available at the moment.",
        buttonText: "Try Again",
      );
    }

    if (statusRequest == StatusRequest.exeption) {
      return _statusWidget(
        icon: Icons.error_outline_rounded,
        title: "Something Went Wrong",
        message: "An unexpected error occurred. Please try again.",
        buttonText: "Try Again",
      );
    }

    return widget;
  }

  Widget _statusWidget({
    required IconData icon,
    required String title,
    required String message,
    required String buttonText,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 45, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            if (onRetry != null)
              SizedBox(
                width: 130,
                height: 42,
                child: ElevatedButton(
                  onPressed: onRetry,
                  child: Text(buttonText),
                ),
              ),

            if (onBack != null) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: 130,
                height: 42,
                child: OutlinedButton.icon(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Back"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
