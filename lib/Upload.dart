// create a blank screen here with state

import 'package:flutter/material.dart';

void main() {
  runApp(const Upload());
}

enum RecipeType { meat, vegetable, seafood, appetizer, dessert }
TextEditingController titleController = TextEditingController();

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final _formKey = GlobalKey();
  final List _ingredientsList = [''];
  final List _instructionList = [''];

  RecipeType? _type = RecipeType.meat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  "Judul Resep",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    hintText: 'Masukkan judul...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: Text(
                  "Tipe Resep",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.only(left: 20, right: 20),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) => Row(
                  children: [
                    Expanded(
                      child: DynamicTextField(
                        key: UniqueKey(),
                        initialValue: _ingredientsList[index],
                        onChanged: (v) => _ingredientsList[index] = v,
                        hintText: "Masukkan bahan...",
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    _textfieldBtn(index, _ingredientsList),
                  ],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: _ingredientsList.length,
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                child: Text(
                  "Instruksi Resep",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListView.separated(
                padding: EdgeInsets.only(left: 20, right: 20),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) => Row(
                  children: [
                    Expanded(
                      child: DynamicTextField(
                        key: UniqueKey(),
                        initialValue: _instructionList[index],
                        onChanged: (v) => _instructionList[index] = v,
                        hintText: "Masukkan instruksi...",
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    _textfieldBtn(index, _instructionList),
                  ],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
                itemCount: _instructionList.length,
              ),
              ListTile(
                title: const Text("Daging"),
                leading: Radio<RecipeType>(
                  value: RecipeType.meat,
                  groupValue: _type,
                  onChanged: (RecipeType? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Sayur"),
                leading: Radio<RecipeType>(
                  value: RecipeType.vegetable,
                  groupValue: _type,
                  onChanged: (RecipeType? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Boga Bahari"),
                leading: Radio<RecipeType>(
                  value: RecipeType.seafood,
                  groupValue: _type,
                  onChanged: (RecipeType? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Makanan Pembuka"),
                leading: Radio<RecipeType>(
                  value: RecipeType.appetizer,
                  groupValue: _type,
                  onChanged: (RecipeType? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("Makanan Penutup"),
                leading: Radio<RecipeType>(
                  value: RecipeType.dessert,
                  groupValue: _type,
                  onChanged: (RecipeType? value) {
                    setState(() {
                      _type = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text("Upload Foto"),
                        IconButton(
                          icon: Icon(Icons.add_a_photo),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Upload Video"),
                        IconButton(
                          icon: Icon(Icons.video_call),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ElevatedButton(
                  
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(double.infinity, 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide.none,
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  child: Text("Upload"),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) {
                    //     return AlertDialog(
                    //       title: const Text("Berhasil upload!"),
                    //       content: const Text(
                    //           "Data yang anda masukkan berhasil diunggah"),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //           },
                    //           child: const Text("OK"),
                    //         ),
                    //       ],
                    //     );
                    //   }),
                    // );
                    String judul = titleController.text;
                    print(_ingredientsList);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textfieldBtn(int index, List list) {
    bool isLast = index == list.length - 1;

    return InkWell(
      onTap: () => setState(
        () => isLast ? list.add('') : list.removeAt(index),
      ),
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: isLast ? Colors.green : Colors.red,
        ),
        child: Icon(
          isLast ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}

class DynamicTextField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final String? hintText;

  const DynamicTextField({
    Key? key,
    this.initialValue,
    required this.onChanged,
    this.hintText,
  }) : super(key: key);

  @override
  _DynamicTextFieldState createState() => _DynamicTextFieldState();
}

class _DynamicTextFieldState extends State<DynamicTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return "Tidak boleh kosong";
        return null;
      },
    );
  }
}
