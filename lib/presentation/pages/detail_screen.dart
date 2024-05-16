import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/detail/detail_bloc.dart';
import 'package:flutter_stories_app/data/bloc/detail/detail_event.dart';
import 'package:flutter_stories_app/presentation/widgets/display_loading.dart';
import 'package:go_router/go_router.dart';

import '../../data/bloc/detail/detail_state.dart';
import '../../utils/date_convert.dart';
import '../widgets/custom_error_screen.dart';

class DetailScreen extends StatelessWidget {
  final String id;

  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailBloc>(context).add(GetDetailStoryEvent(id: id));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Story App'),
            leading: BackButton(
              color: Colors.black,
              onPressed: () {
                context.pop();
              },
            )
        ),
        body: BlocConsumer<DetailBloc, DetailStates>(
          builder: (BuildContext context, DetailStates state) {
            if (state is OnLoading) {
              return customLoading();
            } else if (state is OnSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(state.response.photoUrl),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          state.response.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(dateConverter(state.response.createdAt),
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontStyle: FontStyle.italic)),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 3,
                          color: Colors.black12,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          state.response.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else if (state is OnError) {
              return CustomError(onRefresh: () {
                BlocProvider.of<DetailBloc>(context)
                    .add(GetDetailStoryEvent(id: id));
              });
            } else {
              return Container();
            }
          },
          listener: (BuildContext context, DetailStates state) {},
        ));
  }
}
