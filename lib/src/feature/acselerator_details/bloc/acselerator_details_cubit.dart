import 'package:coworking_mobile/src/feature/acselerator_details/bloc/acselerator_details_state.dart';
import 'package:coworking_mobile/src/feature/acselerator_details/data/acselerator_details_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcseleratorDetailsCubit extends Cubit<AcseleratorDetailsState> {
  final AcseleratorDetailsRepository _acseleratorDetailsRepository;

  AcseleratorDetailsCubit(
    this._acseleratorDetailsRepository,
  ) : super(const AcseleratorDetailsState.idle());

  Future<void> load(String id) async {
    try {
      emit(AcseleratorDetailsState.idle());
      final acselectorDetails =
          await _acseleratorDetailsRepository.getAcselectorDetails(id);
      emit(
          AcseleratorDetailsState.loaded(acselectorDetails: acselectorDetails));
    } on Object catch (e, st) {
      onError(e, st);
    }
  }
}
