import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:coding_interview_flutter_app/src/app/config/routes/app_routing.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/app_bar.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/model/announcement.dart';
import 'package:flutter/material.dart';

class AnnouncementDetailScreen extends StatefulWidget {
  const AnnouncementDetailScreen({
    Key? key,
    required this.announcement,
  }) : super(key: key);

  final Announcement announcement;

  @override
  _AnnouncementDetailScreenState createState() =>
      _AnnouncementDetailScreenState();
}

class _AnnouncementDetailScreenState extends State<AnnouncementDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.announcement.title,
        color: AppColors.backgroundGrey,
        onTap: () => AppRouting.backToPrevious(context),
      ),
      body: ListView(
        children: [
          Icon(
            Icons.assignment_turned_in,
            size: getScreenHeight(160),
          ),
          Container(
            margin: EdgeInsets.only(top: getScreenWidth(20)),
            padding: EdgeInsets.only(top: getScreenWidth(20)),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [

              ],
            ),
          )
          // TopRoundedContainer(
          //   color: Colors.white,
          //   child: Column(
          //     children: [
          //       ProductDescription(
          //         product: product,
          //         pressOnSeeMore: () {},
          //       ),
          //       TopRoundedContainer(
          //         color: Color(0xFFF6F7F9),
          //         child: Column(
          //           children: [
          //             ColorDots(product: product),
          //             TopRoundedContainer(
          //               color: Colors.white,
          //               child: Padding(
          //                 padding: EdgeInsets.only(
          //                   left: SizeConfig.screenWidth * 0.15,
          //                   right: SizeConfig.screenWidth * 0.15,
          //                   bottom: getProportionateScreenWidth(40),
          //                   top: getProportionateScreenWidth(15),
          //                 ),
          //                 child: DefaultButton(
          //                   text: "Add To Cart",
          //                   press: () {},
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
