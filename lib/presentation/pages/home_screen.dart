import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/home/home_bloc.dart';
import 'package:flutter_stories_app/data/bloc/home/home_event.dart';
import 'package:flutter_stories_app/data/bloc/home/home_state.dart';
import 'package:flutter_stories_app/data/model/story.dart';
import 'package:flutter_stories_app/presentation/widgets/custom_error_screen.dart';
import 'package:flutter_stories_app/presentation/widgets/custom_menu_tile.dart';
import 'package:flutter_stories_app/presentation/widgets/display_loading.dart';
import 'package:flutter_stories_app/route/route_name.dart';
import 'package:flutter_stories_app/utils/date_convert.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_snack_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeBloc bloc;
  final ScrollController _scrollController = ScrollController();
  final List<Story> story = [];

  @override
  void initState() {
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(const GetStoryListEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        if(bloc.page != null) {
          bloc.add(const GetStoryListEvent());
        }
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          elevation: 4,
          title: const Text('Story App'),
        ),
        endDrawer: Drawer(
          child: SafeArea(
              child: CustomTile(
            title: 'Keluar',
            onTap: () {
              BlocProvider.of<HomeBloc>(context).add(OnLogOutEvent());
            },
            customIcon: Icons.exit_to_app,
          )),
        ),
        body: BlocConsumer<HomeBloc, HomeStates>(builder: (context, state) {
          if (state is OnLoading) {
            return customLoading();
          } else if (state is OnSuccess) {
            return Center(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (context, idx) {
                  if(idx == story.length && bloc.page != null) {
                    return customLoading();
                  } else {
                    return _customListItem(context, story[idx]);
                  }
                },
                itemCount: story.length + (bloc.page != null ? 1 : 0),
              ),
            );
          } else if (state is OnError) {
            return CustomError(onRefresh: () {
              BlocProvider.of<HomeBloc>(context).add(const GetStoryListEvent());
            });
          } else {
            return Container();
          }
        }, listener: (BuildContext context, HomeStates state) {
          bloc.page == 1;
          if (state is DoLogOut) {
            context.goNamed(RouteName.login);
          } else if (state is OnError) {
            customSnackBar(StatusSnackBar.error, state.error);

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(StatusSnackBar.error, state.error));
          } else if(state is OnSuccess) {
            story.addAll(state.response);
          }
        }),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () {
              bloc.page = 1;
              context.pushReplacementNamed(RouteName.add);
        }));
  }

  Widget _customListItem(BuildContext context, Story story) {
    return InkWell(
      onTap: () {
        bloc.page = 1;
        context.pushReplacementNamed(RouteName.detail, pathParameters: {'id': story.id});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            story.photoUrl,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  story.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  story.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(dateConverter(story.createdAt),
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontStyle: FontStyle.italic)),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 1,
                  color: Colors.black12,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
