import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;

class CustomPlaceMark extends StatelessWidget {
  final geo.Placemark placeMark;
  final Function() onSavePressed;

   const CustomPlaceMark({super.key, required this.placeMark, required this.onSavePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
          color: Colors.green,
          boxShadow: [
            BoxShadow(
                blurRadius: 20,
                offset: Offset.zero,
                color: Colors.grey.withOpacity(0.5))
          ],
          borderRadius:  const BorderRadius.all(Radius.circular(16))),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                placeMark.street ?? "tidak di ketahui",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                '${placeMark.subLocality}, ${placeMark.locality}, ${placeMark.postalCode}, ${placeMark.country}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.white),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
                child: ElevatedButton(
                    onPressed: onSavePressed,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: const Text('Simpan Lokasi')),
              )
            ],
          ))
        ],
      ),
    );
  }
}
