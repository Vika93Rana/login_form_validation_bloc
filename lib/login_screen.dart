import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_cubit/bloc/auth_bloc.dart';
import 'package:login_form_cubit/home_screen.dart';
import 'package:login_form_cubit/widgets/gradient_button.dart';
import 'package:login_form_cubit/widgets/login_field.dart';
import 'package:login_form_cubit/widgets/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// BlocListener -> to listen the changes in the state OR
      /// used for functionality that needs to occur once per state change
      /// such as navigation, snackbar, dialog, etc
      /// BlocBuilder -> used to handle the UI in response to state change
      /// Parent -> BlocListener | Child -> BlocBuilder (Nesting)
      /// Alternative to the above (without nesting)
      /// BlocConsumer -> combination of blocBuilder and blocListener
      ///
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: question: Diff between BlocListener and BlocBuilder
          /// it will listen to state change
          /// can navigate to another page
          /// display snackbar
          /// BlocBuilder ui was rebuild
          /// BlocListener - we can catch a particular state and act
          /// accordingly like if password is < 6 chars show snackbar
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
          if (state is AuthSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
          }

          /// show dialog can be done here
          /// basically all the service can be done from here(BlocListener)
          /// BUt not UI
          /// circularProgress indicator can't be accessed from here
          /// but UI elements can be accessed from BlocBuilder
        },
        builder: (BuildContext context, AuthState state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/images/signin_balls.png'),
                  const Text(
                    'Sign in.',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const SocialButton(
                      iconPath: 'assets/svgs/g_logo.svg',
                      label: 'Continue with Google'),
                  const SizedBox(height: 20),
                  const SocialButton(
                    iconPath: 'assets/svgs/f_logo.svg',
                    label: 'Continue with Facebook',
                    horizontalPadding: 90,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'or',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  GradientButton(
                    label: 'Sign in',
                    onPressed: () {
                      /// got the Bloc with the help of BlocProvider
                      /// which was defined in main.dart
                      /// first catch the event or add the event in bloc
                      /// on press pass the email and pass to bloc
                      context.read<AuthBloc>().add(AuthLoginRequested(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          ));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
