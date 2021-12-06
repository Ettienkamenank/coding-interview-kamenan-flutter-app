import 'package:coding_interview_flutter_app/src/app/config/app_colors.dart';
import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:coding_interview_flutter_app/src/app/config/routes/app_routing.dart';
import 'package:coding_interview_flutter_app/src/app/core/providers/authentication/sign_in/sign_in_cubit.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/authentication/register/register_screen.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/home/home_screen.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/button.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/input_text.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/loader.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/modal.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/reusable_widgets.dart';
import 'package:coding_interview_flutter_app/src/app/utils/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<AppInputFieldOnContainerState> _usernameKey, _passwordKey;

  late TextEditingController _usernameController, _passwordController;

  @override
  void initState() {
    super.initState();

    _usernameKey = GlobalKey<AppInputFieldOnContainerState>();
    _usernameController = TextEditingController();

    _passwordKey = GlobalKey<AppInputFieldOnContainerState>();
    _passwordController = TextEditingController();

    _initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInScreenReady) {
            if (state.username.isNotEmpty) {
              _usernameController.text = state.username;
            }
          }
          if (state is SignInError) {
            if (state.message.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                customSnackBar(message: state.message, radius: 10),
              );
            }
          }
          if (state is SignInSuccess) {
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
                buildAuthenticationLogoCard(
                    message: 'Bienvenue, connectez-vous'),
                if (state is SignInInitial || state is SignInLoading) ...[
                  const AppLoader(
                    boxHeight: .6,
                    loaderSize: 40,
                    loaderColor: AppColors.primary,
                    isCircular: false,
                  ),
                ] else ...[
                  _buildLoginForm(),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoginForm() {
    return SizedBox(
      height: AppScreenSize.height! * .6,
      child: Column(
        children: [
          AppInputFieldOnContainer(
            key: _usernameKey,
            controller: _usernameController,
            validator: Validators.emptyField,
            hintText: 'Username',
            icon: Icons.perm_identity,
            marginTop: 70,
          ),
          AppInputFieldOnContainer(
            key: _passwordKey,
            controller: _passwordController,
            validator: Validators.emptyField,
            hintText: 'Mot de passe',
            icon: Icons.lock,
            marginTop: 20,
          ),
          _buildForgetPasswordRow(),
          AppButtonOnContainer(
            title: 'CONNEXION',
            marginTop: 70,
            onTap: () {
              if (_usernameKey.currentState?.validate() != null) return;
              if (_passwordKey.currentState?.validate() != null) return;

              context.read<SignInCubit>().signInEvent(
                    _usernameController.text,
                    _passwordController.text,
                  );
            },
          ),
          buildGoToNextPageRow(
            question: 'Vous n\'avez pas de compte? ',
            action: 'Inscrivez-vous',
            onTap: () => AppRouting.changeScreenWithRoute(
              context: context,
              screen: const RegisterScreen(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForgetPasswordRow() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          // Write Click Listener Code Here
        },
        child: const Text(
          'Mot de passe oublié ?',
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  void _initialLoad() {
    BlocProvider.of<SignInCubit>(context).setUpScreen();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

//END OF CLASS
}
