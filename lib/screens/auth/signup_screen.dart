import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF0B23F2);

    InputDecoration deco(String hint) => InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text: 'Sign Up',
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

              const Text(
                'Full Name',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _name,
                decoration: deco('Enter your Name Here'),
              ),
              const SizedBox(height: 18),

              const Text(
                'Email Here',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                decoration: deco('abc@gmail.com'),
              ),
              const SizedBox(height: 18),

              const Text(
                'Password',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _pass,
                obscureText: _obscure1,
                decoration: deco('************').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure1
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () => setState(() => _obscure1 = !_obscure1),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              const Text(
                'Conform Password', // matches your mock text exactly
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirm,
                obscureText: _obscure2,
                decoration: deco('************').copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscure2
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () => setState(() => _obscure2 = !_obscure2),
                  ),
                ),
              ),
              const SizedBox(height: 22),

              ElevatedButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),

              const SizedBox(height: 22),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Have An Account ?  '),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushReplacementNamed(context, '/login'),
                    child: Text(
                      'Sign In Here',
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
