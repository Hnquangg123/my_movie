import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/util/app_colors.dart';
import 'package:my_movie/presentation/registration/blocs/registration_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PolicyTickbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return Row(
          children: [
            Checkbox(
              value: state.tickPolicy,
              onChanged: (value) {
                print(value);
                context
                    .read<RegistrationBloc>()
                    .add(RegistrationTickPolicyChanged(value: value ?? false));
              },
              checkColor: AppColors.onSurfaceColor,
              activeColor: AppColors.surfaceColor,
            ),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse(
                    'https://github.com/Hnquangg123/hnquangg123-privacy/blob/main/privacy-policy.md'));
              },
              child: const Text(
                'I agree to the Privacy Policy',
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        );
      },
    );
  }
}
