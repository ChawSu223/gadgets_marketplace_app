import 'package:flutter_bloc/flutter_bloc.dart';

class SearchHeaderState {
  bool showAppbarSearchIcon;

  SearchHeaderState({required this.showAppbarSearchIcon});
}

class SearchHeaderCubit extends Cubit<SearchHeaderState> {
  SearchHeaderCubit() : super(SearchHeaderState(showAppbarSearchIcon: false));
  void updateShowAppbarSearchIcon(double offset) {
    if (offset > 40 && !state.showAppbarSearchIcon) {
      emit(SearchHeaderState(showAppbarSearchIcon: true));
    } else if (offset <= 40 && state.showAppbarSearchIcon) {
      emit(SearchHeaderState(showAppbarSearchIcon: false));
    }
  }

  
}
