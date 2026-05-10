import 'package:flutter/material.dart';
import '../screens/event_list_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit(bool isAdmin) {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => EventListScreen(isAdmin: isAdmin),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFff9a76), Color(0xFFffcd6a)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'EventFlow',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'A bright and accessible event platform for users and admins.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 32),
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email address',
                                hintText: 'admin@example.com',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: '••••••••',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 28),
                            ElevatedButton(
                              onPressed: () => _submit(false),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(52),
                                backgroundColor: const Color(0xFF2f9bff),
                              ),
                              child: const Text('Continue as User', style: TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(height: 14),
                            OutlinedButton(
                              onPressed: () => _submit(true),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size.fromHeight(52),
                                side: const BorderSide(color: Colors.white54),
                              ),
                              child: const Text('Continue as Admin', style: TextStyle(fontSize: 16, color: Colors.black87)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
