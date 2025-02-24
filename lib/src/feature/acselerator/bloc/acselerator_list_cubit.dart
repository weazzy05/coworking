import 'package:coworking_mobile/src/feature/acselerator/bloc/acselerator_list_state.dart';
import 'package:coworking_mobile/src/feature/acselerator/data/acselerator_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcseleratorListCubit extends Cubit<AcseleratorListState> {
  final AcseleratorListRepository _acseleratorListRepository;

  AcseleratorListCubit(
    this._acseleratorListRepository,
  ) : super(const AcseleratorListState.idle());

  Future<void> load() async {
    try {
      emit(AcseleratorListState.loading());
      final acselectors = await _acseleratorListRepository.getAcseleratorList();
      await Future<void>.delayed(Duration(seconds: 1, milliseconds: 500));
      emit(AcseleratorListState.loaded(roomsList: acselectors));
    } on Object catch (e, st) {
      onError(e, st);
    }
  }
}
