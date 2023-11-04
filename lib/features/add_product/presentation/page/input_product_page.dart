import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klontong/core/entities/product.dart';
import 'package:klontong/features/add_product/presentation/widgets/klontong_input_text.dart';
import 'package:klontong/features/add_product/presentation/widgets/klontong_tag_widget.dart';

class InputProductPage extends StatefulWidget {
  const InputProductPage({super.key});

  @override
  State<InputProductPage> createState() => _InputProductPageState();
}

class _InputProductPageState extends State<InputProductPage> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void clear() {
    _titleCtrl.clear();
    _descCtrl.clear();
    _priceCtrl.clear();
  }

  String _categoryVal = 'Category';

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void resetForm() {
    setState(() {
      image = null;
      _titleCtrl.text = '';
      _categoryVal = 'Category';
      _descCtrl.text = '';
      _priceCtrl.text = '';
      image?.path != null;
    });
  }

  bool isNumericWithDecimal(String input) {
    final numericRegex = RegExp(r'^[0-9.]+$');
    return numericRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final isResetActive = _titleCtrl.text != '' ||
        _categoryVal != 'Category' ||
        _descCtrl.text != '' ||
        _priceCtrl.text != '' ||
        image?.path != null;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // add title
              KlontongInputTextWidget(
                label: 'Product Name',
                controller: _titleCtrl,
                hint: 'ex: Gaming Chair',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 18),
              KlontongTagWidget(
                value: _categoryVal,
                onChange: (value) {
                  _categoryVal = value;
                  setState(() {});
                },
                items: const [
                  'Category',
                  'Men\'s Clothes',
                  'Women\'s Clothes',
                  'Electronic',
                  'Random',
                  'Food',
                ],
              ),
              const SizedBox(height: 18),
              // description
              KlontongInputTextWidget(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _descCtrl,
                maxLines: 4,
                onChanged: (value) {
                  setState(() {});
                },
                label: 'Description',
                hint: 'ex: With rgb color on all over the chair',
              ),
              const SizedBox(height: 18),
              // price
              KlontongInputTextWidget(
                label: 'Price (\$)',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (!isNumericWithDecimal(value)) {
                    return 'Only decimal (. and numeric)';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {});
                },
                controller: _priceCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                hint: 'in dollar (\$)',
              ),
              const SizedBox(height: 18),
              // image
              const Text(
                'Product Image',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  showImageDialog(context);
                },
                child: image?.path != null
                    ? Container(
                        height: 190,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4.0)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(image?.path as String)),
                            )),
                      )
                    : Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.12),
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.image_outlined),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 12,
                              width: 1,
                              color: Colors.black,
                            ),
                            const Icon(Icons.camera_alt_outlined),
                          ],
                        ),
                      ),
              ),
              const SizedBox(height: 18),
              // Send or clear
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          final random = Random();
                          final product = Product(
                            idCount: random.nextInt(999),
                            title: _titleCtrl.text,
                            price: double.parse(_priceCtrl.text),
                            description: _titleCtrl.text,
                            category: _categoryVal == 'Category'
                                ? 'Random'
                                : _categoryVal,
                            imgUrl: image?.path ?? '',
                            // random rating because we don't have rating feature
                            rating: Rating(
                                rate: random.nextInt(5),
                                count: random.nextInt(999)),
                          );
                          showLoading();
                          await Future.delayed(
                            const Duration(milliseconds: 750),
                          );
                        }
                      },
                      child: const Text('Send')),
                  const SizedBox(width: 18),
                  isResetActive
                      ? ElevatedButton(
                          onPressed: resetForm,
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                          child: const Text(
                            'Clear',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showImageDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                },
                child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('Take an image')),
              ),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Upload from your galery'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
