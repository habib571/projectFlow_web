import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:projectflow_web/presentation/features/dashboard/bloc/navigation_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const ItemSelectedState(0)) {
    on<NavigationItemSelected>(_onItemSelected);
  }
  void _onItemSelected(
      NavigationItemSelected event,
      Emitter<NavigationState> emit,
      ) {
    emit(ItemSelectedState(event.index));
  }
}
