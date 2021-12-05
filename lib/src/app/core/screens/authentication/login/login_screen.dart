import 'package:coding_interview_flutter_app/src/app/config/app_screen_size.dart';
import 'package:coding_interview_flutter_app/src/app/config/routes/app_routing.dart';
import 'package:coding_interview_flutter_app/src/app/core/screens/authentication/register/register_screen.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/button.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/input_text.dart';
import 'package:coding_interview_flutter_app/src/app/core/widgets/reusable_widgets.dart';
import 'package:coding_interview_flutter_app/src/app/utils/input_validators.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late GlobalKey<AppInputFieldOnContainerState> _identifierKey, _passwordKey;

  late TextEditingController _identifierController, _passwordController;

  @override
  void initState() {
    super.initState();

    _identifierKey = GlobalKey<AppInputFieldOnContainerState>();
    _identifierController = TextEditingController();

    _passwordKey = GlobalKey<AppInputFieldOnContainerState>();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildAuthenticationLogoCard(message: 'Bienvenue, connectez-vous'),
            _buildLoginForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return SizedBox(
      height: AppScreenSize.height! * .6,
      child: Column(
        children: [
          AppInputFieldOnContainer(
            key: _identifierKey,
            controller: _identifierController,
            validator: Validators.emptyField,
            hintText: 'Téléphone / Email',
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
              if (_identifierKey.currentState?.validate() != null) return;
              if (_passwordKey.currentState?.validate() != null) return;
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

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

//END OF CLASS
}
