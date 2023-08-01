import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CastCard extends StatelessWidget {
  final String imgUrl, castName, character;
  const CastCard(
      {super.key,
      required this.imgUrl,
      required this.castName,
      required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 200,
                width: 140,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imgUrl,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 75),
                        child: Icon(
                          size: 50,
                          color: Colors.white,
                          Icons.image_not_supported_outlined,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            // height: 40,
            child: Text(
              castName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Text(
            character,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
