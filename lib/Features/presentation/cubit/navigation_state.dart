abstract class NavigationState {
  const NavigationState();
}

class NavigationInitial extends NavigationState {}

class NavigationChanged extends NavigationState {
  final int currentIndex;

  const NavigationChanged(this.currentIndex);
}