import 'package:coworking_mobile/src/feature/rooms_list/bloc/rooms_list_state.dart';
import 'package:coworking_mobile/src/feature/rooms_list/data/rooms_list_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsListCubit extends Cubit<RoomsListState> {
  final RoomsListRepository _roomsListRepository;

  RoomsListCubit(
    this._roomsListRepository,
  ) : super(const RoomsListState.idle());

  Future<void> load(String cityId) async {
    try {
      emit(RoomsListState.loading(roomsList: state.roomsList));
      final roomsList = await _roomsListRepository.getRooms(cityId);
      await Future<void>.delayed(Duration(seconds: 1, milliseconds: 500));
      emit(RoomsListState.loaded(roomsList: roomsList));
    } on Object catch (e, st) {
      onError(e, st);
    }
  }
}
