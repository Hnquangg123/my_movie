import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_movie/domain/profile/repositories/i_profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@Injectable()
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IProfileRepository _profileRepository;

  ProfileBloc(this._profileRepository) : super(ProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<ProfileNameChanged>(_onProfileNameChanged);
    on<ProfilePhoneChanged>(_onProfilePhoneChanged);
  }

  Future<void> _onLoadUserProfile(
      LoadUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _profileRepository.fetchUserProfile();
      emit(ProfileLoaded(name: profile['username'], phone: profile['phone']));
    } catch (e) {
      emit(ProfileError(message: 'Failed to load profile'));
    }
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(
      name: event.name,
      phone: event.phone,
      status: FormUpdateStatus.submitting,
    ));
    try {
      await _profileRepository.updateUserProfile(event.name, event.phone);
      emit(state.copyWith(
        name: event.name,
        phone: event.phone,
        status: FormUpdateStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: FormUpdateStatus.failure));
    }
  }

  void _onProfileNameChanged(
      ProfileNameChanged event, Emitter<ProfileState> emit) {
    // if (state is ProfileLoaded) {
    //   final currentState = state as ProfileLoaded;
    //   emit(currentState.copyWith(name: event.name));
    // }
    // emit(state.copyWith(name: event.name));
  }

  void _onProfilePhoneChanged(
      ProfilePhoneChanged event, Emitter<ProfileState> emit) {
    // if (state is ProfileLoaded) {
    //   final currentState = state as ProfileLoaded;
    //   emit(currentState.copyWith(phone: event.phone));
    // }
    // emit(state.copyWith(phone: event.phone));
  }
}
