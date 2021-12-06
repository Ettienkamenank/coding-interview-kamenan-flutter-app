import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:coding_interview_flutter_app/src/app/config/routes/app_routing.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/home/home_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/announcement/announcement_detail.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/announcement/creat_announcement_screen.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/loader.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/modal.dart';
import 'package:coding_interview_flutter_app/src/domain/announcement/model/announcement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liste des annonces',
          style: TextStyle(
            color: AppColors.light,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: AppColors.primary,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRouting.changeScreenWithRoute(
          context: context,
          screen: const CreateAnnouncementScreen(),
        ),
        child: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(message: state.message, radius: 10),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is HomeInitial || state is HomeLoading) {
            return const Center(
              child: AppLoader(
                boxHeight: .2,
                loaderSize: 40,
                loaderColor: AppColors.primary,
                isCircular: false,
              ),
            );
          } else if (state is HomeScreenReady) {
            return state.announcements.isNotEmpty
                ? SizedBox(
                    height: AppScreenSize.height! * .9,
                    child: ListView.builder(
                      itemCount: state.announcements.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildAnnouncementCard(
                          announcement: state.announcements.elementAt(index),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Text('Aucune Annonce'),
                  );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildAnnouncementCard({required Announcement announcement}) {
    const kUserCardTextStyle = TextStyle(
      fontSize: 13,
      color: AppColors.icon,
    );

    return Padding(
      padding: EdgeInsets.all(getScreenWidth(20)),
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () => AppRouting.changeScreenWithRoute(
            context: context,
            screen: AnnouncementDetailScreen(announcement: announcement),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.4,
                child: Container(
                  padding: EdgeInsets.all(getScreenWidth(20)),
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Hero(
                        tag: announcement.id,
                        child: Icon(
                          Icons.assignment_turned_in,
                          size: getScreenHeight(80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        announcement.title,
                        style: TextStyle(
                          fontSize: getScreenHeight(16),
                          color: AppColors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        announcement.description,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Auteur: ',
                              style: kUserCardTextStyle,
                              children: [
                                TextSpan(
                                  text: announcement.customer.fullName,
                                  style: TextStyle(
                                    fontSize: getScreenWidth(15),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(50),
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.all(getScreenWidth(8)),
                              height: getScreenWidth(40),
                              width: getScreenWidth(40),
                              decoration: BoxDecoration(
                                color: announcement.isReported
                                    ? AppColors.primary.withOpacity(0.15)
                                    : AppColors.primary.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.report,
                                  size: getScreenHeight(25),
                                  color: announcement.isReported
                                      ? const Color(0xFFFF4848)
                                      : AppColors.primaryLight,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initialLoad() {
    BlocProvider.of<HomeCubit>(context).setUpScreen();
  }

// End of class
}
