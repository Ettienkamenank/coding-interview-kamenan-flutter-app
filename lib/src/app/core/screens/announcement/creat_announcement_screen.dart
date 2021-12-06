import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:coding_interview_flutter_app/src/app/config/routes/app_routing.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/announcement/create_announcement/create_announcement_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/home/home_screen.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/app_bar.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/button.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/dropdown.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/input_text.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/loader.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/modal.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/reusable_widgets.dart';
import 'package:coding_interview_flutter_app/src/app/utils/input_validators.dart';
import 'package:coding_interview_flutter_app/src/domain/activity_area/model/activity_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({Key? key}) : super(key: key);

  @override
  _CreateAnnouncementScreenState createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  late GlobalKey<AppInputFieldOnContainerState> _titleKey, _descriptionKey;
  late TextEditingController _titleController, _descriptionController;

  @override
  void initState() {
    super.initState();

    _titleKey = GlobalKey<AppInputFieldOnContainerState>();
    _titleController = TextEditingController();

    _descriptionKey = GlobalKey<AppInputFieldOnContainerState>();
    _descriptionController = TextEditingController();

    _initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Créez votre annonce',
        color: AppColors.backgroundGrey,
        onTap: () => AppRouting.backToPrevious(context),
      ),
      body: BlocConsumer<CreateAnnouncementCubit, CreateAnnouncementState>(
        listener: (context, state) {
          if (state is CreateAnnouncementError) {
            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(message: state.message, radius: 10),
              );
            }
          }
          if (state is CreateAnnouncementSuccess) {
            AppRouting.changeScreenWithRoute(
              context: context,
              screen: const HomeScreen(),
              transitionType: PageTransitionType.fade,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                if (state is CreateAnnouncementInitial ||
                    state is CreateAnnouncementLoading) ...[
                  const AppLoader(
                    boxHeight: .6,
                    loaderSize: 40,
                    loaderColor: AppColors.primary,
                    isCircular: false,
                  ),
                ] else if (state is CreateAnnouncementReady) ...[
                  _buildCreateAnnouncementForm(
                    areas: state.areas,
                    selectedActivityArea: state.selectedActivityArea,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreateAnnouncementForm({
    required List<ActivityArea> areas,
    required ActivityArea selectedActivityArea,
  }) {
    return SizedBox(
      height: AppScreenSize.height! * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choisissez le secteur d'activité",
                  style: TextStyle(fontSize: 16, color: AppColors.grey),
                ),
                SizedBox(height: getScreenHeight(10)),
                CustomDropDown(
                  errorText: "",
                  hint: 'Selectionnez le type de déclaration',
                  items: areas.map<DropdownMenuItem<ActivityArea>>(
                      (ActivityArea value) {
                    return DropdownMenuItem<ActivityArea>(
                      child: Text(
                        value.title,
                        style: const TextStyle(color: AppColors.primaryLight),
                      ),
                      value: value,
                    );
                  }).toList(),
                  value: selectedActivityArea,
                  onChanged: (newValue) {
                    if (selectedActivityArea != (newValue as ActivityArea)) {
                      context
                          .read<CreateAnnouncementCubit>()
                          .changeArea(newValue);
                    }
                  },
                ),
              ],
            ),
          ),
          AppInputFieldOnContainer(
            key: _titleKey,
            controller: _titleController,
            validator: Validators.emptyField,
            hintText: 'Titre',
            icon: Icons.title,
            marginTop: 5,
          ),
          SizedBox(height: getScreenHeight(20)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 16, color: AppColors.grey),
                ),
                SizedBox(height: getScreenHeight(10)),
                Card(
                  color: const Color(0xFFEEEEEE),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLines: 8,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Saisissez une description de votre annonce",
                      ),
                      controller: _descriptionController,
                      key: _descriptionKey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppButtonOnContainer(
            title: 'CREER L\'ANNONCE',
            marginTop: 30,
            onTap: () {
              if (_titleKey.currentState?.validate() != null) return;
              if (_descriptionController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(
                    message: 'La description est obligatoire',
                    radius: 10,
                  ),
                );
                return;
              }

              context.read<CreateAnnouncementCubit>().createAnnouncementEvent(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    activityAreaId: selectedActivityArea.id.toString(),
                  );
            },
          ),
        ],
      ),
    );
  }

  void _initialLoad() {
    BlocProvider.of<CreateAnnouncementCubit>(context).setUpScreen();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

//END OF CLASS
}
