part of 'nav_bloc.dart';

sealed class NavEvent extends Equatable {
  const NavEvent();

  @override
  List<Object> get props => [];
}

class NavigateHomePage extends NavEvent {}

class NavigateProfilePage extends NavEvent {}

class NavigateSearchPage extends NavEvent {}

class NavigateRecommendationPage extends NavEvent {}
