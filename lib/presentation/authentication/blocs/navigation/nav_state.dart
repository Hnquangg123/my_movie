part of 'nav_bloc.dart';

enum OnPage { navigateHomePage, navigateProfilePage, navigateSearchPage }

sealed class NavState extends Equatable {
  @override
  List<Object> get props => [];
}

final class NavInitial extends NavState {}

final class HomePage extends NavState {
  OnPage get title => OnPage.navigateHomePage;

  @override
  List<Object> get props => [title];
}

final class Profile extends NavState {
  OnPage get title => OnPage.navigateProfilePage;

  @override
  List<Object> get props => [title];
}

final class Search extends NavState {
  OnPage get title => OnPage.navigateSearchPage;

  @override
  List<Object> get props => [title];
}
