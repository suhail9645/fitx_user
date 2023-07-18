import 'package:fitx_user/presentation/constants/colors.dart';
import 'package:fitx_user/presentation/constants/lists.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 18,color: primaryColor);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Terms and Conditions',
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'We welcome you to FitX and thank you for you support in making FitX a leading fitness training platform'
              'we sincerly encourage you to go through the below terms of service to understand the platforms features and your'
              'responsibilities while using the platform .do not hesitate to contact us for any queries.',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Color.fromARGB(255, 204, 198, 198)),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Privacy policy',
                style: textStyle,
              ),
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 128, 125, 125),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'At FitX, we take your privacy very seriously. This Privacy Policy outlines how we collect, use, and protect your personal information when you use our app. By using our app, you agree to the terms of this Privacy Policy.',
              style: TextStyle(
                  color: Color.fromARGB(255, 219, 215, 215), fontSize: 15),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Information We Collect',
                style: textStyle,
              ),
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 128, 125, 125),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: List.generate(
                privacyPolicyList.length,
                (index) => CustomListTile(text: privacyPolicyList[index]),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'We use your personal information to provide you with a personalized experience in our app. We use your email address to send you updates about new stories or features in our app. We may also use your information for research purposes to improve our app and its features.',
              style: TextStyle(
                color: Color.fromARGB(255, 219, 215, 215),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'We will never share your personal information with third parties without your consent. We may, however, disclose your information to law enforcement or government officials if required by law.',
              style: TextStyle(color: Color.fromARGB(255, 219, 215, 215)),
            ),
          ),
        const  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Security',
                style: textStyle,
              ),
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 128, 125, 125),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'We take the security of your personal information very seriously. We use industry-standard security measures to protect your information from unauthorized access, disclosure, or alteration.',
              style: TextStyle(color: Color.fromARGB(255, 219, 215, 215)),
            ),
          ),
        const  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Changes to Privacy Policy',
                style: textStyle,
              ),
            ],
          ),
          const Divider(
            color: Color.fromARGB(255, 128, 125, 125),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'We reserve the right to update this Privacy Policy at any time. We will notify you of any changes by posting the new Privacy Policy on our website. Your continued use of our app after any changes to this Privacy Policy will signify your acceptance of those changes.',
              style: TextStyle(color: Color.fromARGB(255, 219, 215, 215)),
            ),
          ),
      const    Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thank you',
                style: textStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class CustomListTile extends Row {
  CustomListTile({super.key, required text})
      : super(children: [
          const Icon(
            Icons.circle,
            size: 15,
            color:primaryColor,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ]);
}
