import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:only_facts/bloc/bloc_facts/facts_bloc.dart';
import 'package:only_facts/widget/facts_card.dart';
import 'package:shimmer/shimmer.dart';

class FactsMain extends StatefulWidget {
  const FactsMain({Key? key}) : super(key: key);

  @override
  State<FactsMain> createState() => _FactsMainState();
}

class _FactsMainState extends State<FactsMain> {
  FactStatus factsStatus = FactStatus.initial;
  FactsBloc factsBloc = FactsBloc();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    factsBloc = context.read<FactsBloc>();
    factsBloc.add(LoadFactsList());
    _scrollController.addListener(_onScroll);
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _onScroll() {
    if (_isBottom) factsBloc.add(LoadFactsList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text("OnlyFacts"),
      ),
      body: Container(
        child: BlocListener<FactsBloc, FactsState>(
          listener: (context, state) {
            setState(() {
              factsStatus = state.factStatus;
            });
          },
          child: BlocBuilder<FactsBloc, FactsState>(
            builder: (cotext, state) {
              if (factsStatus == FactStatus.initial) {
                return const Center(child: CircularProgressIndicator());
              }
              if (factsStatus == FactStatus.failure) {
                return const Center(
                  child: Text("Failed to Load Data"),
                );
              }
              if (factsStatus == FactStatus.success) {
                return Column(children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.hasReachedMax
                          ? state.factsList.length
                          : state.factsList.length + 1,
                      itemBuilder: (context, index) {
                        return index >= state.factsList.length
                            ? BottomLoader()
                            : FactsCard(facts: state.factsList[index].facts);
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                ]);
              }
              return Text("Awww Man, Your Internet Sucks");
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    factsBloc.close();
    super.dispose();
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).accentColor),
        ),
        child: const Center(child: Text("Loading")),
      ),
    );
  }
}
