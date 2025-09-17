class Contact {
  final String name;
  final String phone;
  final String? email;
  final String? imagePath;

  Contact({
    required this.name, 
    required this.phone,
    this.email,
    this.imagePath,
    });
}

