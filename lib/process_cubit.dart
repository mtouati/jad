import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'process_state.dart';

class ProcessCubit extends Cubit<ProcessState> {
  ProcessCubit() : super(const ProcessState.initial());

  Future<void> initiate() async {
    emit(const ProcessState.pause(0));
  }

  Future<void> goAhead() async {
    double _speed = 100;
    int _count = 80;

    emit(ProcessState.reading(state.index));

    while ((state.index < _count - 1) &&
        (state.status == ListStatusProcess.reading)) {
      try {
        emit(ProcessState.reading(state.index + 1));
        await _sleep(_speed);
      } on Exception {
        emit(const ProcessState.failure());
      }
      if (state.index >= _count - 1) {
        emit(const ProcessState.reading(0));
      }
    }
  }

  void pause() {
    emit(ProcessState.pause(state.index));
  }

  /// sleep

  Future<void> _sleep(double speed) async {
    return await Future.delayed(
      Duration(
        seconds: (50.0 / speed).round(),
      ),
    );
  }
}
