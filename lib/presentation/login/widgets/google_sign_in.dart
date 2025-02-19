import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_movie/presentation/login/blocs/login_bloc.dart';

class GoogleSignInIcon extends StatelessWidget {
  const GoogleSignInIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => GestureDetector(
        onTap: () async {
          state.isSubmiting() || !state.isValid
              ? null
              : context.read<LoginBloc>().add(GoogleIconPressed());
        },
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: FaIcon(
            FontAwesomeIcons.google,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

}
