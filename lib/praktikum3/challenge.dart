import 'package:flutter/material.dart';

import 'tugas.dart';

class Bebas extends StatefulWidget {
  const Bebas({super.key});

  @override
  State<Bebas> createState() => _BebasState();
}

class _BebasState extends State<Bebas> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<String> _registeredEmails = <String>[];
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => const AddTransactionScreen(),
        ),
      );
    }
  }

  Future<void> _registerAccount() async {
    final registrationFormKey = GlobalKey<FormState>();
    final registrationEmailController = TextEditingController();

    final registeredEmail = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Daftar akun'),
          content: Form(
            key: registrationFormKey,
            child: TextFormField(
              controller: registrationEmailController,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'nama@email.com',
                prefixIcon: Icon(Icons.mail_outline_rounded),
              ),
              validator: (value) {
                final email = value?.trim() ?? '';
                if (email.isEmpty) {
                  return 'Email wajib diisi';
                }
                if (!email.contains('@')) {
                  return 'Masukkan email yang valid';
                }
                if (_registeredEmails.contains(email.toLowerCase())) {
                  return 'Email sudah terdaftar';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                if (registrationFormKey.currentState!.validate()) {
                  Navigator.pop(
                    context,
                    registrationEmailController.text.trim().toLowerCase(),
                  );
                }
              },
              child: const Text('Daftar'),
            ),
          ],
        );
      },
    );

    registrationEmailController.dispose();

    if (registeredEmail != null) {
      setState(() => _registeredEmails.add(registeredEmail));
      _showMessage(
        'Email berhasil didaftarkan. Total akun: ${_registeredEmails.length}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colors.primary.withValues(alpha: 0.24),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.lock_rounded,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Selamat datang kembali',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF172033),
                        fontSize: 27,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Masuk untuk melanjutkan ke akun Anda',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF697386), fontSize: 15),
                    ),
                    const SizedBox(height: 36),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'nama@email.com',
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email wajib diisi';
                        }
                        if (!value.contains('@')) {
                          return 'Masukkan email yang valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        labelText: 'Kata sandi',
                        hintText: 'Masukkan kata sandi',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        suffixIcon: IconButton(
                          tooltip: _obscurePassword
                              ? 'Tampilkan kata sandi'
                              : 'Sembunyikan kata sandi',
                          onPressed: () {
                            setState(
                              () => _obscurePassword = !_obscurePassword,
                            );
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Kata sandi wajib diisi';
                        }
                        if (value.length < 6) {
                          return 'Kata sandi minimal 6 karakter';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => _showMessage(
                          'Tautan pemulihan kata sandi akan dikirim ke email Anda',
                        ),
                        child: const Text('Lupa kata sandi?'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: _submit,
                      child: const Text('Masuk'),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Belum punya akun? ',
                          style: TextStyle(color: Color(0xFF697386)),
                        ),
                        TextButton(
                          onPressed: _registerAccount,
                          child: const Text('Daftar akun'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
