import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/core/config/dependency_injection.dart';
import 'package:my_movie/presentation/authentication/widgets/logout_button.dart';
import 'package:my_movie/presentation/profile/blocs/profile_bloc.dart';
import 'package:my_movie/presentation/profile/widgets/profile_form.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final profileBloc = getIt<ProfileBloc>();
        profileBloc.add(LoadUserProfile());
        return profileBloc;
      },
      child: const ProfileContent(),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: LogoutButton(),
        ),
      ),
      body: Center(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return Center(
                child: SingleChildScrollView(
                  child: ProfileForm(name: state.name, phone: state.phone),
                ),
              );
            } else if (state is ProfileError) {
              return Center(
                child: SingleChildScrollView(
                  child: ProfileForm(name: state.name, phone: state.phone),
                ),
              );
            } else {
              print(state);
              return Center(
                child: SingleChildScrollView(
                  child: ProfileForm(name: state.name, phone: state.phone),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
