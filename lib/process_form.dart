import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as developer;

import 'package:testlecture/process_cubit.dart';

class ProcessForm extends StatelessWidget {
  const ProcessForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ProcessCubit()..initiate(),
      child: BlocBuilder<ProcessCubit, ProcessState>(
        builder: (context1, state) {
          developer.log('Index---- ${state.index}', name: 'ProcessForm');
          if ((state.status == ListStatusProcess.reading) ||
              (state.status == ListStatusProcess.pause)) {
            return Padding(
              padding: const EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Center(
                      child: Text(
                        state.index.toString(),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Center(
                      child: Text(
                        state.status.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        (state.status == ListStatusProcess.reading)
                            ? IconButton(
                                icon: const Icon(Icons.pause),
                                onPressed: () =>
                                    context1.read<ProcessCubit>().pause(),
                                iconSize: 60,
                              )
                            : IconButton(
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () async => await context1
                                    .read<ProcessCubit>()
                                    .goAhead(),
                                iconSize: 60,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
