import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_form_cubit/bloc/auth_bloc.dart';
import 'package:login_form_cubit/login_screen.dart';
import 'package:login_form_cubit/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// context.watch() keeps/constantly listeneing to any change in the state
    /// in a particular provider
    /// issue -> whenever the state changes the entire Scaffold will
    /// be rebuild
    /// resolution -> use blocBuilder instead
    // final authState = context.watch<AuthBloc>().state as AuthSuccess;
    return Scaffold(
        appBar: AppBar(title: Text('Home')),

        /// need to show something from state -> implement BlocBuilder
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthInital) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            }
          },
          builder: (context, state) {
            if(state is AuthLoading){
              return const Center(child: CircularProgressIndicator());
            }
            // final authState = context.watch<AuthBloc>().state as AuthSuccess;
            return Column(
              children: [
                Center(
                  child: Text((state as AuthSuccess).uid),
                ),
                GradientButton(
                  onPressed: () {
                    /// context.read() is a one time event
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                  label: 'Log out',
                ),
              ],
            );
          },
        ));
  }
}
