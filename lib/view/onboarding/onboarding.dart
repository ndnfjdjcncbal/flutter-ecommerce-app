import 'package:ecommerce/core/counstant/colore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/onboarding/onboarding_controller.dart';

class onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    onboardingcon con = Get.put(onboardingcon());

    return Scaffold(
      body: GetBuilder<onboardingcon>(
        builder: (con) => Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  con.updatepage(index);
                },
                itemCount: con.pages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        SizedBox(height: 69.5),
                        Container(
                          height: 350,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [],
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset(
                              con.pages[index]["image"]!,
                              fit: BoxFit.cover,
                              height: 10,
                            ),
                          ),
                        ),
                        SizedBox(height: 40),

                        Text(
                          con.pages[index]["title"]!,
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),

                        Text(
                          con.pages[index]["subtitle"]!,
                          style: TextStyle(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 90),
              child: ElevatedButton(
                onPressed: () {
                  con.updatepage1();
                },
                child: Text("Next"),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                con.pages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 320),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: con.currentpage == index ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: con.currentpage == index
                        ? Color(0xFF5B4FCF)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
