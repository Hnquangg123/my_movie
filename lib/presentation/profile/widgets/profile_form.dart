import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_movie/presentation/profile/blocs/profile_bloc.dart';

class ProfileForm extends StatelessWidget {
  final String name;
  final String phone;

  const ProfileForm({required this.name, required this.phone, super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String nameData = name;
    String phoneData = phone;

    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == FormUpdateStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Update success.")),
          );
        } else if (state.status == FormUpdateStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Update failed.")),
          );
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) => current.name != previous.name,
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: nameData,
                      decoration: const InputDecoration(labelText: 'Name'),
                      onChanged: (value) {
                        nameData = value;
                        context
                            .read<ProfileBloc>()
                            .add(ProfileNameChanged(name: value));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    );
                  },
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  buildWhen: (previous, current) => current.phone != previous.phone,
                  builder: (context, state) {
                    return TextFormField(
                      initialValue: phoneData,
                      decoration: const InputDecoration(labelText: 'Phone'),
                      onChanged: (value) {
                        phoneData = value;
                        context
                            .read<ProfileBloc>()
                            .add(ProfilePhoneChanged(phone: value));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<ProfileBloc>().add(
                                UpdateUserProfile(
                                    name: nameData, phone: phoneData),
                              );
                        }
                      },
                      child: Text(
                          state.isSubmitting() ? 'Updating' : 'Update Profile'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
