part of 'navigation_bloc.dart';

sealed class NavigationState extends Equatable {
  const NavigationState();
}

class ItemSelectedState extends NavigationState {
  final int selectedIndex;

  const ItemSelectedState(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}