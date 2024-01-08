import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:markazapp/Models/categories_model.dart';


class StoriesCard extends StatefulWidget {
  final CategoriesModel stories;
  
  const StoriesCard({Key? key, required this.stories}) : super(key: key);

  @override
  State<StoriesCard> createState() => _StoriesCardState();
}

class _StoriesCardState extends State<StoriesCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.red, // Set the color of the border here
              width: 2.0, // Set the width of the border here
            ),
          ),
          child: CircleAvatar(
            radius: 29,
            backgroundImage: CachedNetworkImageProvider(widget.stories.imageUrl ?? ''), // Use stories.imageUrl here
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Container(
            width: 80,
            child: Center(child: Text("${widget.stories.name}", maxLines: 1, overflow: TextOverflow.ellipsis)),
          ),
        ),
      ],
    );
  }
}
