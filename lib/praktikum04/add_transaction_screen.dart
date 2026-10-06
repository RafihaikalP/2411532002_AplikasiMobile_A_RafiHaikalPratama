import 'package:flutter/material.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController(); // controller baru untuk tanggal

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Memunculkan date picker lalu mengisi field tanggal
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.red),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final String formatted =
          "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";

      setState(() {
        _dateController.text = formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Catat Transaksi"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                    labelText: "Judul", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Nominal", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),

              // ============ INPUT TANGGAL (bagian tugas) ============
              TextFormField(
                controller: _dateController,
                readOnly: true, // hanya bisa diisi lewat date picker
                onTap: _pickDate,
                decoration: InputDecoration(
                  labelText: "Tanggal Transaksi",
                  hintText: "DD/MM/YYYY",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.red),
                    onPressed: _pickDate,
                  ),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? "Tanggal wajib diisi" : null,
              ),
              // =========================================================

              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16)),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Transaksi Berhasil Disimpan!'),
                          backgroundColor: Colors.green),
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text("Simpan", style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
      ),
    );
  }
}