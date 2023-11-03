import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  String _categoryVal = 'Category';

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // add title
            const KlontongInputTextWidget(
              label: 'Product Name',
              hint: 'ex: Gaming Chair',
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
            const KlontongInputTextWidget(
              maxLines: 4,
              label: 'Description',
              hint: 'ex: With rgb color on all over the chair',
            ),
            const SizedBox(height: 18),
            const KlontongInputTextWidget(
              label: 'Price (\$)',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              hint: 'in dollar (\$)',
            ),
            const SizedBox(height: 18),

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
          ],
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
}
