import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_edusoft/censo/data/repository/censo_repository.dart';
import 'package:teste_edusoft/censo/logic/censo_details/censo_detail_bloc.dart';
import 'package:teste_edusoft/censo/logic/censo_details/censo_detail_event.dart';
import 'package:teste_edusoft/censo/logic/censo_details/censo_detail_state.dart';

class DetailsPage extends StatefulWidget {
  final CensoRepository repo;
  final String nome;
  const DetailsPage({super.key, required this.repo, required this.nome});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late final ScrollController _scrollController;
  late final CensoDetailBloc _censoDetailsBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _censoDetailsBloc = CensoDetailBloc(repo: widget.repo)..add(FetchDetailsEvent(nome: widget.nome));
  }

  void _onScroll() {
    if (_isBottom) _censoDetailsBloc.add(FetchDetailsEvent(nome: widget.nome));
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 250);
  }

  @override
  void dispose() {
    _censoDetailsBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _censoDetailsBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Censo Detalhe'),),
        body: BlocBuilder<CensoDetailBloc, CensoDetailState>(
          builder: (context, state) {
            if (state is CensoDetailSucess) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.periodos.length,
                itemBuilder: (context, index) {
                  final censo = state.periodos[index];
                  return Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Período: ${censo.periodo}'),
                        Text('Frequência: ${censo.frequencia}'),
                      ],
                    ),
                  );
                }
              );
            } else if (state is CensoDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CensoDetailFailure) {
              return Center(
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      Text(state.message),
                      ElevatedButton(
                        onPressed: () {
                          _censoDetailsBloc.add(FetchDetailsEvent(nome: widget.nome));
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