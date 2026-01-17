import 'package:flutter/material.dart';
import '../../services/service_locator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0B23F2); // button color like your mock

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              // Title
              Text.rich(
                TextSpan(
                  text: 'Sign In',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                  ),
                  children: [
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Lorem Ipsum Dolor Sit Amet Consectetur. Tincidunt Et',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Email
              const Text(
                'Email Here',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'abc@gmail.com',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Password
              const Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pass,
                obscureText: _obscure,
                decoration: InputDecoration(
                  hintText: '************',
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
              ),

              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {}, // TODO: implement
                  child: const Text('Forget Password?'),
                ),
              ),
              const SizedBox(height: 8),

              // Sign In button
              ElevatedButton(
                // onPressed: () {
                //   // Temporary navigation for UI development
                //   Navigator.pushNamed(context, '/home');
                // },
                onPressed: () async {
                  try {
                    final userId = await ServiceLocator.auth.login(
                      _email.text,
                      _pass.text,
                    );

                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                      arguments: userId,
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid login credentials'),
                      ),
                    );
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'SIGN IN',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),

              const SizedBox(height: 22),

              // Divider text: Or Sign In With
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Or Sign In With'),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 18),

              // Facebook button
              SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () {}, // TODO: FB auth
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1877F2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: Image.asset(
                    'assets/facebook.png',
                    width: 22,
                    height: 22,
                  ),
                  label: const Text(
                    'Sign In with Facebook',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Google button
              SizedBox(
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: () {}, // TODO: Google auth
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE0E0E0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: Image.asset('assets/google.png', width: 22, height: 22),
                  label: const Text(
                    'Sign In with Google',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              // Bottom link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't Have An Account ?  "),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/signup'),
                    child: Text(
                      'Sign Up Here',
                      style: TextStyle(
                        color: primaryBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
