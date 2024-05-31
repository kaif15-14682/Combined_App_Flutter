import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'personal_info.dart';
import 'personal_info_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  String name = "";
  File? _photo;
  String bio = "";
  String contactDetails = "";
  String cvLink = "";

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _photo = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Fill the Box and click to Save",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 251, 255, 254),
              ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _photo != null ? FileImage(_photo!) : null,
                    child: _photo == null
                        ? Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.grey,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField('Name', onChanged: (value) => name = value),
              const SizedBox(height: 18),
              _buildTextField('Bio', onChanged: (value) => bio = value),
              const SizedBox(height: 18),
              _buildTextField(
                'Contact Details',
                onChanged: (value) => contactDetails = value,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'CV Link',
                onChanged: (value) => cvLink = value,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _savePersonalInfo(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: const Color.fromARGB(255, 254, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildSavedInfoList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText,
      {required ValueChanged<String> onChanged}) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
    );
  }

  void _savePersonalInfo(BuildContext context) {
    if (name.isNotEmpty &&
        bio.isNotEmpty &&
        contactDetails.isNotEmpty &&
        cvLink.isNotEmpty) {
      final photoUrl = _photo?.path ?? '';

      final personalInfo = PersonalInfo(
        name: name,
        photoUrl: photoUrl,
        bio: bio,
        contactDetails: contactDetails,
      );

      Provider.of<PersonalInfoProvider>(context, listen: false)
          .addPersonalInfo(personalInfo);

      // Reset the text fields after saving
      setState(() {
        name = "";
        _photo = null;
        bio = "";
        contactDetails = "";
        cvLink = "";
      });
    } else {
      // Show a snackbar or other feedback for incomplete information
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
    }
  }

  Widget _buildSavedInfoList(BuildContext context) {
    final personalInfoList =
        Provider.of<PersonalInfoProvider>(context).personalInfoList;

    if (personalInfoList.isEmpty) {
      return Container(); // If there's no saved info, return an empty container
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Saved Information:',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200, // Set a fixed height or use constraints
          child: ListView.separated(
            itemCount: personalInfoList.length,
            itemBuilder: (context, index) {
              final info = personalInfoList[index];
              return ListTile(
                leading: info.photoUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: FileImage(File(info.photoUrl)),
                      )
                    : CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                title: Text(
                  info.name,
                  style:
                      const TextStyle(color: Colors.black), // Change text color
                ),
                subtitle: Text(
                  info.contactDetails,
                  style:
                      const TextStyle(color: Colors.black), // Change text color
                ),
                onTap: () {
                  _showInfoDialog(context, info.toString());
                },
              );
            },
            separatorBuilder: (context, index) =>
                const Divider(color: Color.fromARGB(255, 0, 0, 0)),
            shrinkWrap:
                true, // Allow the ListView to occupy only the space it needs
          ),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context, String info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Saved Information',
            style: TextStyle(color: Colors.black), // Change text color
          ),
          content: Text(
            info,
            style: const TextStyle(color: Colors.black), // Change text color
          ),
          backgroundColor:
              const Color.fromARGB(255, 0, 0, 0), // Change dialog box color
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.black), // Change text color
              ),
            ),
          ],
        );
      },
    );
  }
}
