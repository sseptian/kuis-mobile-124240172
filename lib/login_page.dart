import 'package:flutter/material.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    // Validasi input kosong dan menampilkan pesan
    if (username.isEmpty && password.isEmpty) {
      _showMessage('Username dan password tidak boleh kosong!', isError: true);
      return;
    }
    if (username.isEmpty) {
      _showMessage('Username tidak boleh kosong!', isError: true);
      return;
    }
    if (password.isEmpty) {
      _showMessage('Password tidak boleh kosong!', isError: true);
      return;
    }

    // Validasi username dan password
    if (username == 'septian' && password == '172') {
      _showMessage('Login berhasil! Selamat berbelanja, $username');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(username: username)),
      );
    } else {
      _showMessage(
        'Username atau Password salah! (Username: septian, Password: 172)',
        isError: true,
      );
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 36.0,
              vertical: 24.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Uniqlo Merah
                Container(
                  width: 420,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Image.network(
                    'https://play-lh.googleusercontent.com/bB_cyOTbQfFmV4IaeqTIFJVc1Wm4UdQwQai8GjthG4uaXrTHNZTKsMtg9_9058GeZGLgoJzIasYYdFkSvdyQ',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE60012),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Text(
                            'UNI\nQLO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 2.0,
                              height: 1.05,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 18),

                // Teks Selamat Datang
                const Text(
                  'Selamat Datang di Uniqlo',
                  style: TextStyle(fontSize: 17, color: Colors.black87),
                ),
                const SizedBox(height: 4),
                Text(
                  'Selamat Berbelanja',
                  style: TextStyle(fontSize: 17, color: Colors.black87),
                ),
                const SizedBox(height: 32),

                // Input Username
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'username',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 247, 246, 246),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Input Password
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'password',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 245, 245, 245),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol Login
                SizedBox(
                  width: 190,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2196F3),
                      foregroundColor: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
