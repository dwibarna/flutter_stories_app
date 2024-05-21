import 'package:flutter/material.dart';
import 'package:flutter_stories_app/data/model/story.dart';
import 'package:flutter_stories_app/presentation/widgets/build_core_detail.dart';

class CustomDraggableSheet extends StatefulWidget {
  final Story story;
  const CustomDraggableSheet({super.key, required this.story});

  @override
  State<StatefulWidget> createState() {
    return _CustomDraggableState();
  }
}


class _CustomDraggableState extends State<CustomDraggableSheet> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.size <= 0.1) _collapse();
    });
    super.initState();
  }

  void _animateSheet(double size) {
    _controller.animateTo(
      size,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DraggableScrollableSheet get sheet => (_sheet.currentWidget as DraggableScrollableSheet);

  void _collapse() => _animateSheet(sheet.snapSizes!.first);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          key: _sheet,
          initialChildSize: 0.5,
          maxChildSize: 1,
          minChildSize: 0.1, // Ensure sheet is always visible
          expand: true,
          snap: true,
          snapSizes: [
            0.1, // Minimum visible size
            0.5, // Midway size
          ],
          controller: _controller,
          builder: (context, scrollController) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Padding(
                      padding: EdgeInsets.all(16),
                    child: buildCoreDetail(widget.story, context),
                  )
                ],
              )

              /*CustomScrollView(
                controller: scrollController,
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Title', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Content', style: TextStyle(fontSize: 16)),
                        ),
                        // Add more content here
                      ],
                    ),
                  ),
                ],
              )*/
            );
          },
        );
      },
    );
  }
}

