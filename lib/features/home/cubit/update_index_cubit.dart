import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateIndexCubit extends Cubit<int> {
  UpdateIndexCubit() : super(0); // စစချင်း 0

  void updateIndex(int index) {
    super.emit(index);
  }
}
