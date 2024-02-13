import 'package:blissful_marry/core/style/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget noteCard(
  Function()? onTap,
  QueryDocumentSnapshot doc,
  double? width,
  double? height,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: light,
        borderRadius: BorderRadius.circular(8),
      ),
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(doc["titlu"],
              style: GoogleFonts.robotoSerif(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(
            height: 5,
          ),
          Text(doc["data"],
              style: GoogleFonts.robotoSerif(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              )),
          const SizedBox(
            height: 15,
          ),
          Text(
            doc["continut"],
            style: GoogleFonts.robotoSerif(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
