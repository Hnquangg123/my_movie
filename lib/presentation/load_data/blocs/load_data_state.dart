part of 'load_data_bloc.dart';

sealed class LoadDataState extends Equatable {
  const LoadDataState();
  
  @override
  List<Object> get props => [];
}

final class LoadDataInitial extends LoadDataState {}
