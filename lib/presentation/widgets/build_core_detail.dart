import 'package:flutter/material.dart';

import '../../data/model/story.dart';
import '../../utils/date_convert.dart';

Widget buildCoreDetail(Story story, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Image.network(story.photoUrl, height: 300, fit: BoxFit.cover,),
      Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              story.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(dateConverter(story.createdAt),
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
              story.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    ],
  );
}
