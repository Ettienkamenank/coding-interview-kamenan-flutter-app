import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:coding_interview_flutter_app/src/app/config/routes/app_routing.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/authentication/register/register_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/authentication/login/login_screen.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/button.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/input_text.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/loader.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/modal.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/reusable_widgets.dart';
import 'package:coding_interview_flutter_app/src/app/utils/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late GlobalKey<AppInputFieldOnContainerState> _firstnameKey,
      _lastnameKey,
      _usernameKey,
      _emailKey,
      _phoneNumberKey,
      _passwordKey,
      _passwordConfirmKey;

  late TextEditingController _firstnameController,
      _lastnameController,
      _usernameController,
      _emailController,
      _phoneNumberController,
      _passwordController,
      _passwordConfirmController;

  @override
  void initState() {
    super.initState();

    _firstnameKey = GlobalKey<AppInputFieldOnContainerState>();
    _firstnameController = TextEditingController();

    _lastnameKey = GlobalKey<AppInputFieldOnContainerState>();
    _lastnameController = TextEditingController();

    _usernameKey = GlobalKey<AppInputFieldOnContainerState>();
    _usernameController = TextEditingController();

    _emailKey = GlobalKey<AppInputFieldOnContainerState>();
    _emailController = TextEditingController();

    _phoneNumberKey = GlobalKey<AppInputFieldOnContainerState>();
    _phoneNumberController = TextEditingController();

    _passwordKey = GlobalKey<AppInputFieldOnContainerState>();
    _passwordController = TextEditingController();

    _passwordConfirmKey = GlobalKey<AppInputFieldOnContainerState>();
    _passwordConfirmController = TextEditingController();

    _initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(message: state.message, radius: 10),
              );
            }
          }
          if (state is RegisterSuccess) {
            AppRouting.changeScreenWithRoute(
              context: context,
              screen: const LoginScreen(),
              transitionType: PageTransitionType.fade,
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                buildAuthenticationLogoCard(message: 'Créez votre compte'),
                if (state is RegisterInitial || state is RegisterLoading) ...[
                  const AppLoader(
                    boxHeight: .6,
                    loaderSize: 40,
                    loaderColor: AppColors.primary,
                    isCircular: false,
                  ),
                ] else ...[
                  _buildRegisterForm(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRegisterForm() {
    return SizedBox(
      height: AppScreenSize.height! * .6,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppInputFieldOnContainer(
              key: _lastnameKey,
              controller: _lastnameController,
              validator: Validators.emptyField,
              hintText: 'Nom',
              icon: Icons.perm_identity,
              marginTop: 20,
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
              key: _emailKey,
              controller: _emailController,
              inputType: TextInputType.emailAddress,
              validator: Validators.validateEmail,
              hintText: 'Email',
              icon: Icons.mail,
              marginTop: 20,
            ),
            AppInputFieldOnContainer(
              key: _usernameKey,
              controller: _usernameController,
              validator: Validators.emptyField,
              hintText: 'Username',
              icon: Icons.perm_identity,
              marginTop: 20,
            ),
            AppInputFieldOnContainer(
              key: _phoneNumberKey,
              controller: _phoneNumberController,
              inputType: TextInputType.number,
              validator: Validators.validatePhoneNumber,
              hintText: 'Numéro téléphone',
              icon: Icons.phone,
              marginTop: 20,
            ),
            AppInputFieldOnContainer(
              key: _passwordKey,
              controller: _passwordController,
              validator: Validators.emptyField,
              hintText: 'Mot de passe',
              icon: Icons.lock,
              marginTop: 20,
            ),
            AppInputFieldOnContainer(
              key: _passwordConfirmKey,
              controller: _passwordConfirmController,
              validator: Validators.emptyField,
              hintText: 'Mot de passe',
              icon: Icons.lock,
              marginTop: 20,
            ),
            AppButtonOnContainer(
              title: 'CONTINUER',
              marginTop: 20,
              onTap: () {
                if (_lastnameKey.currentState?.validate() != null) return;
                if (_firstnameKey.currentState?.validate() != null) return;
                if (_emailKey.currentState?.validate() != null) return;
                if (_usernameKey.currentState?.validate() != null) return;
                if (_phoneNumberKey.currentState?.validate() != null) return;
                if (_passwordKey.currentState?.validate() != null) return;

                if (_passwordController.text != _passwordConfirmController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    customSnackBar(
                      message: 'Mot de passe non identique',
                      radius: 10,
                    ),
                  );
                  return;
                }

                context.read<RegisterCubit>().registerUserEvent(
                      _firstnameController.text,
                      _lastnameController.text,
                      _emailController.text,
                      _usernameController.text,
                      _phoneNumberController.text,
                      _passwordController.text,
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
      ),
    );
  }

  void _initialLoad() {
    BlocProvider.of<RegisterCubit>(context).setUpScreen();
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

//END OF CLASS
}
