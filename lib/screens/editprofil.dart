import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isEditingName = false;
  bool isEditingEmail = false;

  String gender = '';
  String birthdate = '';
  String height = '';
  String weight = '';

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  /// ================= LOAD =================
  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    // Birthdate (ISO → readable)
    final birthIso = prefs.getString('birthdate');
    String formattedBirthdate = '-';
    if (birthIso != null) {
      final date = DateTime.tryParse(birthIso);
      if (date != null) {
        formattedBirthdate = DateFormat('dd MMM yyyy').format(date);
      }
    }

    // Height & Weight
    final h = prefs.getDouble('height');
    final w = prefs.getDouble('weight');

    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      gender = prefs.getString('gender') ?? '-';
      birthdate = formattedBirthdate;
      height = h != null ? '${h.toInt()} cm' : '-';
      weight = w != null ? '${w.toInt()} kg' : '-';
    });
  }

  /// ================= SAVE =================
  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F3B),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1F3B),
        elevation: 0,
        centerTitle: true,
        title: const Text('Edit Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          /// AVATAR
          const CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFF23264A),
            child: Icon(Icons.person, size: 46, color: Colors.white70),
          ),

          const SizedBox(height: 30),

          /// EDITABLE
          editableField(
            label: 'Nama',
            controller: nameController,
            isEditing: isEditingName,
            onEditTap: () {
              setState(() => isEditingName = true);
            },
          ),

          editableField(
            label: 'Email',
            controller: emailController,
            isEditing: isEditingEmail,
            onEditTap: () {
              setState(() => isEditingEmail = true);
            },
          ),

          /// READ ONLY (REGISTER DATA)
          readOnlyField('Gender', gender),
          readOnlyField('Date of birth', birthdate),
          readOnlyField('Height', height),
          readOnlyField('Weight', weight),

          const SizedBox(height: 30),

          /// SAVE BUTTON
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A8A8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () async {
                await saveProfile();
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= EDITABLE FIELD =================
  Widget editableField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEditTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54)),
        const SizedBox(height: 6),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF23264A),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: isEditing,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onEditTap,
                child: const Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  /// ================= READ ONLY FIELD =================
  Widget readOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54)),
        const SizedBox(height: 6),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF23264A),
            borderRadius: BorderRadius.circular(14),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
