import 'package:flutter_bloc/flutter_bloc.dart';

class ShowSearchCategoryCubit extends Cubit<bool> {
  ShowSearchCategoryCubit() : super(true);
  void showSearchCategory(bool isShowSearchCategory) {
    super.emit(isShowSearchCategory);
  }
}
