import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/censo/data/repository/censo_repository.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_bloc.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_event.dart';
import 'package:teste_edusoft/censo/logic/censo_ranking/censo_state.dart';
import 'package:teste_edusoft/censo/routes/app_routes.dart';

class RankingPage extends StatefulWidget {
  final CensoRepository repo;
  const RankingPage({super.key, required this.repo});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  late final ScrollController _scrollController;
  late final CensoBloc _censoBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _censoBloc = CensoBloc(repo: widget.repo)..add(FetchRankingEvent());
  }

  void _onScroll() {
    if (_isBottom) _censoBloc.add(FetchRankingEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 250);
  }

  @override
  void dispose() {
    _censoBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _censoBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Censo'),),
        body: BlocBuilder<CensoBloc, CensoState>(
          builder: (context, state) {
            if (state is CensoSucess) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.ranking.length,
                itemBuilder: (context, index) {
                  final censo = state.ranking[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.details, arguments: censo.nome);
                    },
                    child: Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('# ${censo.ranking}'),
                          Text('Nome: ${censo.nome}'),
                          Text('Frequência: ${censo.frequencia}'),
                        ],
                      ),
                    ),
                  );
                }
              );
            } else if (state is CensoLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CensoFailure) {
              return Center(
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Text(state.message),
                      ElevatedButton(
                        onPressed: () {
                          _censoBloc.add(FetchRankingEvent());
                        }, 
                        child: Text('Tentar Novamente')
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          }
        ),
      ),
    );
  }
}