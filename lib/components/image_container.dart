import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jarnama_app/components/image_card.dart';
import 'package:jarnama_app/services/image_picker_services.dart';

// ignore: must_be_immutable
class ImageContainer extends StatefulWidget {
  ImageContainer({
    super.key,
    required this.images,
    required this.onPicked,
    required this.onDelete,
  });
  List<XFile> images;
  final void Function(List<XFile> image) onPicked;
  final void Function(XFile) onDelete;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  final service = ImagePickerService();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: widget.images.isNotEmpty
            ? SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: widget.images.length,
                      itemBuilder: (context, index) {
                        return ImageCard(
                          file: widget.images[index],
                          delete: (xfile) {
                            widget.images.remove(xfile);
                            widget.onDelete(xfile);
                            setState(() {});
                          },
                        );
                      },
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: IconButton(
                        onPressed: () async {
                          final value = await service.pickImages();
                          if (value != null) {
                            widget.onPicked(value);
                            widget.images = value;
                            setState(() {});
                          }
                        },
                        icon: const Icon(
                          Icons.camera_enhance,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: IconButton(
                    onPressed: () async {
                      final value = await service.pickImages();
                      if (value != null) {
                        widget.onPicked(value);
                        widget.images = value;
                        setState(() {});
                      }
                    },
                    icon: const Icon(
                      Icons.camera_enhance,
                      size: 30,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
