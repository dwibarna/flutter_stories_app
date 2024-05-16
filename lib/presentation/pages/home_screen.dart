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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBloc>(context).add(const GetStoryListEvent());
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
                itemBuilder: (context, idx) {
                  return _customListItem(context, state.response[idx]);
                },
                itemCount: state.response.length,
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
          if (state is DoLogOut) {
            context.goNamed(RouteName.login);
          } else if (state is OnError) {
            customSnackBar(StatusSnackBar.error, state.error);

            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(customSnackBar(StatusSnackBar.error, state.error));
          }
        }),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () {
              context.pushReplacementNamed(RouteName.add);
        }));
  }

  Widget _customListItem(BuildContext context, Story story) {
    return InkWell(
      onTap: () {
        context.pushNamed(RouteName.detail, pathParameters: {'id': story.id});
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
