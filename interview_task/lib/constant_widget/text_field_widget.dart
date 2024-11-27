import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatelessWidget {
  final String? title;
  final String hintText;
  final validator;
  final TextEditingController controller;
  final Function() onPress;
  final bool? enabled;
  final bool? readOnly;
  final TextInputType? keyboardType;

  const TextFieldWidget(
      {super.key,
      this.title,
      required this.hintText,
      this.validator,
      required this.controller,
      required this.onPress,
      this.enabled,
        this.keyboardType,

        this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Visibility(
          visible: title != null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ?? '', style: const TextStyle(fontSize: 14)),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onPress,
          child: TextFormField(
            validator: validator ??
                (value) => value != null && value.isNotEmpty
                    ? null
                    : 'This field required'.tr,
            keyboardType: keyboardType?? TextInputType.text,
            controller: controller,
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.grey),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.grey),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.grey),
              ),
              enabled: enabled ?? true,
              hintText: hintText,
              hintStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }
}
