import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/detail/detail_bloc.dart';
import 'package:flutter_stories_app/data/bloc/detail/detail_event.dart';
import 'package:flutter_stories_app/presentation/widgets/build_core_detail.dart';
import 'package:flutter_stories_app/presentation/widgets/custom_dragable_sheet.dart';
import 'package:flutter_stories_app/presentation/widgets/cutom_map_view.dart';
import 'package:flutter_stories_app/presentation/widgets/display_loading.dart';
import 'package:go_router/go_router.dart';

import '../../data/bloc/detail/detail_state.dart';
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
              return Stack(
                children: [
                  state.response.lat != null && state.response.lon != null
                  ? CustomMapView(
                      lat: state.response.lat!,
                      long: state.response.lon!,
                    infoPlaceMark: state.info!
                  )
                  : buildCoreDetail(state.response, context),
                  state.response.lat != null && state.response.lon != null
                  ? CustomDraggableSheet(story: state.response)
                  : Container()
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
