import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jarnama_app/components/custom_text_field.dart';
import 'package:jarnama_app/components/image_container.dart';
import 'package:jarnama_app/services/date_time_service.dart';

// ignore: must_be_immutable
class AppProductPage extends StatelessWidget {
  AppProductPage({Key? key}) : super(key: key);
  final title = TextEditingController();
  final desc = TextEditingController();
  final dateTime = TextEditingController();
  final phone = TextEditingController();
  final userName = TextEditingController();
  final address = TextEditingController();
  final price = TextEditingController();
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppProducttPage'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CustomTextField(
            controller: title,
            hintText: 'Title',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: desc,
            maxLines: 4,
            hintText: 'Description',
          ),
          const SizedBox(height: 12),
          ImageContainer(
            images: images,
            onPicked: (value) => images = value,
            onDelete: (xfile) => images.remove(xfile),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: dateTime,
            hintText: 'DateTime',
            focusNode: FocusNode(),
            onTap: () async {
              await DateTimeService.showDateTimePicker(
                context,
                (value) => dateTime.text = DateFormat("d MMM, y").format(value),
              );
            },
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: phone,
            hintText: 'Phone Number',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: userName,
            hintText: 'User Name',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: address,
            hintText: 'Address',
          ),
          const SizedBox(height: 12),
          CustomTextField(
            controller: price,
            hintText: 'Price',
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.publish),
            label: const Text('Add to FireStore'),
          ),
        ],
      ),
    );
  }
}
