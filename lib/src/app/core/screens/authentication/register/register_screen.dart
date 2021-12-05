import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:coding_interview_flutter_app/src/app/config/routes/app_routing.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/authentication/login/login_screen.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/button.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/input_text.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/reusable_widgets.dart';
import 'package:coding_interview_flutter_app/src/app/utils/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<AppInputFieldOnContainerState> _firstnameKey,
      _lastnameKey,
      _phoneNumberKey;

  late TextEditingController _firstnameController,
      _lastnameController,
      _phoneNumberController;

  @override
  void initState() {
    super.initState();

    _firstnameKey = GlobalKey<AppInputFieldOnContainerState>();
    _firstnameController = TextEditingController();

    _lastnameKey = GlobalKey<AppInputFieldOnContainerState>();
    _lastnameController = TextEditingController();

    _phoneNumberKey = GlobalKey<AppInputFieldOnContainerState>();
    _phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAuthenticationLogoCard(message: 'Créez votre compte'),
            _buildRegisterForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterForm() {
    return SizedBox(
      height: AppScreenSize.height! * .6,
      child: Column(
        children: [
          AppInputFieldOnContainer(
            key: _lastnameKey,
            controller: _lastnameController,
            validator: Validators.emptyField,
            hintText: 'Nom',
            icon: Icons.perm_identity,
            marginTop: 70,
          ),
          AppInputFieldOnContainer(
            key: _firstnameKey,
            controller: _firstnameController,
            validator: Validators.emptyField,
            hintText: 'Prenom(s)',
            icon: Icons.perm_identity,
            marginTop: 20,
          ),
          AppInputFieldOnContainer(
            key: _phoneNumberKey,
            controller: _phoneNumberController,
            validator: Validators.validatePhoneNumber,
            hintText: 'Numéro téléphone',
            icon: Icons.lock,
            marginTop: 20,
          ),
          AppButtonOnContainer(
            title: 'CONTINUER',
            marginTop: 70,
            onTap: () {
              // if (_lastnameKey.currentState?.validate() != null) return;
              // if (_firstnameKey.currentState?.validate() != null) return;
              // if (_phoneNumberKey.currentState?.validate() != null) return;

              AppRouting.changeScreenWithRoute(
                context: context,
                screen: const LoginScreen(),
                transitionType: PageTransitionType.rightToLeftWithFade,
              );
            },
          ),
          buildGoToNextPageRow(
            question: 'Vous avez déjà un compte? ',
            action: 'Connectez-vous',
            onTap: () => AppRouting.backToPrevious(context),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _phoneNumberController.dispose();

    super.dispose();
  }

//END OF CLASS
}
