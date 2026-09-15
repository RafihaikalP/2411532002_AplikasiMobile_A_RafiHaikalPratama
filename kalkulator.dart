import 'package:flutter/material.dart';

class Kalkulator extends StatefulWidget {
  const Kalkulator({super.key});

  @override
  State<Kalkulator> createState() => _KalkulatorState();
}

class _KalkulatorState extends State<Kalkulator> {
  final TextEditingController _angka1Controller =
      TextEditingController();

  final TextEditingController _angka2Controller =
      TextEditingController();

  String _hasil = 'Hasil: 0';

  double? _ambilAngka1() {
    return double.tryParse(_angka1Controller.text);
  }

  double? _ambilAngka2() {
    return double.tryParse(_angka2Controller.text);
  }

  void _tambah() {
    double? angka1 = _ambilAngka1();
    double? angka2 = _ambilAngka2();

    if (angka1 == null || angka2 == null) {
      setState(() {
        _hasil = 'Masukkan angka yang valid';
      });
      return;
    }

    setState(() {
      _hasil = 'Hasil: ${angka1 + angka2}';
    });
  }

  void _kurang() {
    double? angka1 = _ambilAngka1();
    double? angka2 = _ambilAngka2();

    if (angka1 == null || angka2 == null) {
      setState(() {
        _hasil = 'Masukkan angka yang valid';
      });
      return;
    }

    setState(() {
      _hasil = 'Hasil: ${angka1 - angka2}';
    });
  }

  void _kali() {
    double? angka1 = _ambilAngka1();
    double? angka2 = _ambilAngka2();

    if (angka1 == null || angka2 == null) {
      setState(() {
        _hasil = 'Masukkan angka yang valid';
      });
      return;
    }

    setState(() {
      _hasil = 'Hasil: ${angka1 * angka2}';
    });
  }

  void _bagi() {
    double? angka1 = _ambilAngka1();
    double? angka2 = _ambilAngka2();

    if (angka1 == null || angka2 == null) {
      setState(() {
        _hasil = 'Masukkan angka yang valid';
      });
      return;
    }

    if (angka2 == 0) {
      setState(() {
        _hasil = 'Tidak dapat membagi dengan 0';
      });
      return;
    }

    setState(() {
      _hasil = 'Hasil: ${angka1 / angka2}';
    });
  }

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalkulator Kabataku'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          children: [
            const Text(
              'Kalkulator Operasi Kabataku',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            TextField(
              controller: _angka1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Pertama',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller: _angka2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Angka Kedua',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _tambah,
                    child: const Text('Tambah'),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child: ElevatedButton(
                    onPressed: _kurang,
                    child: const Text('Kurang'),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _kali,
                    child: const Text('Kali'),
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child: ElevatedButton(
                    onPressed: _bagi,
                    child: const Text('Bagi'),
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 30,
            ),

            Text(
              _hasil,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}