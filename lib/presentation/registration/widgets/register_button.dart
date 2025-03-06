import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/registration/blocs/registration_bloc.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) => ElevatedButton(
          onPressed: () => state.isSubmitting() || !state.isValid
              ? null
              : !state.isTickPolicy()
                  ? ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please accept app policy first!'),
                      ),
                    )
                  : context
                      .read<RegistrationBloc>()
                      .add(RegistrationRegisterButtonPressed()),
          child: Text(state.isSubmitting() ? 'Submitting' : 'Register'),
        ),
      );
}
