import 'package:bloc_vs_riverpod_example/data/models/fact.dart';
import 'package:bloc_vs_riverpod_example/domain/api_repository.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/bloc/fact_bloc.dart';
import 'package:bloc_vs_riverpod_example/presentation/state/network/network_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../state/state_notifier/facts_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FactsPage extends ConsumerStatefulWidget {
  const FactsPage({Key? key}) : super(key: key);

  @override
  _FactsState createState() => _FactsState();
}

class _FactsState extends ConsumerState<FactsPage> {
  @override
  Widget build(BuildContext context) {
    final ApiRepository repo = ApiRepository();
    final state = ref.watch(factsNotifierProvider);
    return BlocBuilder<NetworkInfoCubit, ConnectivityResult>(
      builder: (context, connectivityState) {
        return BlocProvider(
          create: (context) => FactBloc(repo),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Random Facts'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoadFactButton(
                  state: state,
                  onPressed: () =>
                      ref.read(factsNotifierProvider.notifier).load(),
                  isConnected: isConnected(connectivityState),
                ),
                const SizedBox(height: 35),
                BlocBuilder<FactBloc, FactState>(
                  builder: (context, state) {
                    return LoadFactButton(
                      state: state,
                      onPressed: () =>
                          context.read<FactBloc>().add(LoadFactEvent()),
                      isConnected: isConnected(connectivityState),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LoadFactButton extends StatelessWidget {
  final FactState state;
  final Function()? onPressed;
  final bool isConnected;
  const LoadFactButton(
      {Key? key,
      required this.state,
      this.onPressed,
      required this.isConnected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: isConnected ? onPressed : null,
          child: const Text('Load random fact'),
        ),
        const SizedBox(height: 25),
        if (state is FactLoadingState)
          const Center(child: CircularProgressIndicator()),
        if (state is FactLoadedState)
          FactCard(
            (state as FactLoadedState).fact,
          ),
      ],
    );
  }
}

class FactCard extends StatelessWidget {
  final Fact fact;
  const FactCard(this.fact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: Text(fact.text),
          ),
        ],
      ),
    );
  }
}
