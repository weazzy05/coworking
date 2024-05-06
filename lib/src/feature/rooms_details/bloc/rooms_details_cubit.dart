import 'package:coworking_mobile/src/feature/rooms_details/bloc/rooms_details_state.dart';
import 'package:coworking_mobile/src/feature/rooms_details/data/rooms_details_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsDetailsCubit extends Cubit<RoomsDetailsState> {
  final RoomsDetailsRepository _roomsDetailsRepository;

  RoomsDetailsCubit(
    this._roomsDetailsRepository,
  ) : super(const RoomsDetailsState.idle());

  Future<void> load(String id) async {
    try {
      emit(RoomsDetailsState.loading());
      final roomDetails = await _roomsDetailsRepository.getRoomsDetails(id);
      emit(RoomsDetailsState.loaded(roomsDetails: roomDetails));
    } on Object catch (e, st) {
      onError(e, st);
    }
  }
}
