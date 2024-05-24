import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stories_app/data/bloc/add/add_event.dart';
import 'package:flutter_stories_app/data/bloc/add/add_state.dart';
import 'package:flutter_stories_app/presentation/widgets/custom_menu_tile.dart';
import 'package:flutter_stories_app/presentation/widgets/display_loading.dart';
import 'package:flutter_stories_app/utils/flavor_config.dart';
import 'package:flutter_stories_app/utils/flavor_type.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/bloc/add/add_bloc.dart';
import '../../route/route_name.dart';
import '../widgets/custom_snack_bar.dart';

class AddStoryScreen extends StatefulWidget {
  const AddStoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddStoryScreen();
  }
}

class _AddStoryScreen extends State<AddStoryScreen> {
  late TextEditingController descController;
  late AddBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AddBloc>(context);
    descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Story App'),
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              context.goNamed(RouteName.home);
            },
          )),
      body: BlocConsumer<AddBloc, AddStates>(builder: (context, state) {
        if (state is GetImageState) {
          return _buildStoryScreen(
              context, state.imagePath, state.imageFile, null);
        } else if (state is OnLoading) {
          return customLoading();
        } else if (state is UpdateDataPaidState) {
          return _buildStoryScreen(
              context, state.imagePath, state.imageFile, state.latLng);
        } else {
          return _buildStoryScreen(context, null, null, null);
        }
      }, listener: (context, state) {
        if (state is AfterUploadState) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                customSnackBar(StatusSnackBar.success, state.message));
          context.goNamed(RouteName.home);
        }

        if (state is OnErrorUpload) {
          customSnackBar(StatusSnackBar.error, state.error);

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(customSnackBar(StatusSnackBar.error, state.error));
        }
      }),
    );
  }

  Widget _buildStoryScreen(BuildContext context, String? imagePath,
      XFile? imageFile, LatLng? latLng) {
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
            flex: 3,
            child: imageFile != null
                ? Image.file(
                    File(imageFile.path),
                    height: 400,
                  )
                : const Icon(
                    Icons.image,
                    size: 100,
                  )),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTile(
                                title: 'Camera',
                                onTap: () => _getImage(context, true, latLng),
                                customIcon: Icons.add_a_photo,
                              ),
                              CustomTile(
                                title: 'Gallery',
                                onTap: () => _getImage(context, false, latLng),
                                customIcon: Icons.add_photo_alternate,
                              )
                            ],
                          );
                        });
                  },
                  child: Text(
                      imageFile == null ? 'Ambil Gambar' : 'Ganti Gambar')),
              FlavorConfig.instance.flavorType == FlavorType.paid
                  ? ElevatedButton(
                      onPressed: () async {
                        final result = await context
                            .pushNamed(RouteName.location, extra: latLng);

                        if (result != null) {
                          bloc.add(UpdateDataPaidEvent(
                              latLng: result as LatLng,
                              imageFile: imageFile,
                              imagePath: imagePath));
                        }
                      },
                      child: Text(
                          latLng == null ? 'Ambil Lokasi' : 'Ganti Lokasi'))
                  : Container(),
              const SizedBox(
                height: 32,
              ),
              TextFormField(
                controller: descController,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  isDense: true,
                  hintText: 'deskripsi',
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                minLines: 1,
                maxLines: 10,
              ),
              const SizedBox(
                height: 16,
              ),
              imageFile != null
                  ? ElevatedButton(
                      onPressed: () async {
                        final fileName = imageFile.name;
                        final bytes = await imageFile.readAsBytes();

                        bloc.add(UploadStoryEvent(
                            bytes: bytes,
                            fileName: fileName,
                            description: descController.text != ''
                                ? descController.text
                                : '',
                            latLng: latLng));
                      },
                      child: const Text('Upload Story'),
                    )
                  : Container()
            ],
          ),
        )
      ],
    ));
  }

  _getImage(BuildContext context, bool i, LatLng? latLng) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        source: i ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      bloc.add(latLng == null
          ? SetImageEvent(imagePath: pickedFile.path, imageFile: pickedFile)
          : UpdateDataPaidEvent(
              imageFile: pickedFile,
              imagePath: pickedFile.path,
              latLng: latLng));
    }
    context.pop();
  }
}
