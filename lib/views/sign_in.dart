import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../controllers/login_controller.dart';
import '../widgets/in_line_text.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _obscureText = true; // State variable to toggle password visibility
  final _signInFormKey =
      GlobalKey<FormState>(); // Key to manage form validation

  @override
  Widget build(BuildContext context) {
    final loginController = Provider.of<LoginController>(context);

    return SingleChildScrollView(
      child: Form(
        key: _signInFormKey,
        child: Column(
          children: [
            const SizedBox(height: 80),
            TextFormField(
              onChanged: (value) => loginController.email = value,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: const Text('E-mail'),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hintText: 'Enter your email',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            TextFormField(
              onChanged: (value) => loginController.password = value,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                label: const Text('Password'),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hintText: 'Enter your password',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(_obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                ),
              ),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black45,
              ),
              keyboardType: TextInputType.text,
              obscureText: _obscureText,
              // Toggle password visibility
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loginController.isLoading
                    ? null
                    : () {
                        if (_signInFormKey.currentState?.validate() ?? false) {
                          loginController.userSignIn(context);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.blue.shade400),
                  ),
                ),
                child: loginController.isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                          strokeWidth: 3.5,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Login'),
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: const Text(
                  'Forgot Password ?',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const InLineText(
              text: 'Or signin with',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () {
                    // Handle Facebook login
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.g_translate),
                  onPressed: () {
                    // Handle Google login
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.apple),
                  onPressed: () {
                    // Handle Apple login
                  },
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an Account? "),
                InkWell(
                    onTap: () {
                      DefaultTabController.of(context)?.animateTo(1);
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(color: Colors.blue.shade400),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
