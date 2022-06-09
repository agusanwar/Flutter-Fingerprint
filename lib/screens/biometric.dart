// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricScreen extends StatefulWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  State<BiometricScreen> createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {
  bool isAvailable = false;
  bool isAuthenticated = false;
  String text = "Please Push Check Boimetric Avaibality";
  LocalAuthentication localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Authenticted'),
        backgroundColor: const Color(0xff0000FF),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                onPressed: () async {
                  isAvailable = await localAuthentication.canCheckBiometrics;
                  if (isAvailable) {
                    List<BiometricType> types =
                        await localAuthentication.getAvailableBiometrics();
                    text = "Biomectic Available";
                    for (var item in types) {
                      text += "\n- $item";
                    }
                    setState(() {});
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.wifi_protected_setup_sharp),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Check Biometrics',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              margin: const EdgeInsets.only(bottom: 10),
              child: RaisedButton(
                onPressed: isAvailable
                    ? () async {
                        isAuthenticated =
                            await localAuthentication.authenticate(
                          localizedReason: "Please Authenticated",
                          options: const AuthenticationOptions(
                            useErrorDialogs: true,
                            stickyAuth: false,
                          ),
                        );
                        setState(() {});
                      }
                    : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Icon(Icons.fingerprint),
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'Authenticated',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: isAuthenticated ? Colors.green : Colors.red),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
