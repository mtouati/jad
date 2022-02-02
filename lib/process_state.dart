part of 'process_cubit.dart';

enum ListStatusProcess { initial, reading, pause, failure }

class ProcessState extends Equatable {
  const ProcessState._({
    this.status = ListStatusProcess.initial,
    this.index = 0,
  });

  const ProcessState.initial() : this._();

  const ProcessState.reading(int index)
      : this._(
          status: ListStatusProcess.reading,
          index: index,
        );

  const ProcessState.pause(int index)
      : this._(
          status: ListStatusProcess.pause,
          index: index,
        );

  const ProcessState.failure() : this._(status: ListStatusProcess.failure);

  final ListStatusProcess status;
  final int index;

  @override
  List<Object> get props => [status, index];
}
