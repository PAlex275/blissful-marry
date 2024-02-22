import 'package:blissful_marry/core/style/colors.dart';
import 'package:blissful_marry/features/subscription/data/subscription_plans.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});
  static const String routeName = "/subscription";

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  final CarouselController controller = CarouselController();
  late int lastIndex;

  @override
  void initState() {
    lastIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ivory,
      appBar: AppBar(
        title: Text(
          'Abonamentul Tău',
          style: GoogleFonts.robotoSerif(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: dustyRose,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: ivory,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarouselSlider.builder(
              carouselController: controller,
              itemCount: 3,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      color: light,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.black.withOpacity(0.1), width: 0.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: dustyRose,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            subscriptionPlans[itemIndex].name,
                            style: GoogleFonts.robotoSerif(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 15,
                        ),
                        child: Container(
                          height: 90,
                          decoration: BoxDecoration(
                            color: nude,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              subscriptionPlans[itemIndex].name.toLowerCase() ==
                                      'plan de baza'
                                  ? subscriptionPlans[itemIndex].price
                                  : '${subscriptionPlans[itemIndex].price}/Luna',
                              style: GoogleFonts.robotoSerif(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: subscriptionPlans[itemIndex]
                                .details
                                .map(
                                  (e) => Text(
                                    '\u2022 $e',
                                    style: GoogleFonts.robotoSerif(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                                .toList()),
                      ),
                    ],
                  ),
                ),
              ),
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    lastIndex = index;
                  });
                },
                enableInfiniteScroll: false,
                height: MediaQuery.of(context).size.height * 0.6,
                viewportFraction: 0.8,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => dustyRose,
                    ),
                  ),
                  onPressed: () {},
                  child: SizedBox(
                    width: 150,
                    height: 45,
                    child: Center(
                      child: Text(
                        'Achita',
                        style: GoogleFonts.robotoSerif(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
