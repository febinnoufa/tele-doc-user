// import 'package:flutter/material.dart';

// class PrivacyPolicyPage extends StatelessWidget {
//   const PrivacyPolicyPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         centerTitle: true,
//         title: const Text('Privacy Policy'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Privacy Policy',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Last updated: July 08, 2024',
//               style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. This Privacy Policy has been created with the help of the Privacy Policy Generator.',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 16),
//             _sectionTitle('Interpretation and Definitions'),
//             _sectionTitle('Interpretation'),
//             _paragraph(
//                 'The words of which the initial letter is capitalized have meanings defined under the following conditions. The following definitions shall have the same meaning regardless of whether they appear in singular or in plural.'),
//             _sectionTitle('Definitions'),
//             _paragraph('For the purposes of this Privacy Policy:'),
//             _bulletPoint(
//                 'Account means a unique account created for You to access our Service or parts of our Service.'),
//             _bulletPoint(
//                 'Affiliate means an entity that controls, is controlled by or is under common control with a party, where "control" means ownership of 50% or more of the shares, equity interest or other securities entitled to vote for election of directors or other managing authority.'),
//             _bulletPoint(
//                 'Application refers to TeleDoc, the software program provided by the Company.'),
//             _bulletPoint(
//                 'Company (referred to as either "the Company", "We", "Us" or "Our" in this Agreement) refers to TeleDoc.'),
//             _bulletPoint('Country refers to: Kerala, India'),
//             _bulletPoint(
//                 'Device means any device that can access the Service such as a computer, a cellphone or a digital tablet.'),
//             _bulletPoint(
//                 'Personal Data is any information that relates to an identified or identifiable individual.'),
//             _bulletPoint('Service refers to the Application.'),
//             _bulletPoint(
//                 'Service Provider means any natural or legal person who processes the data on behalf of the Company. It refers to third-party companies or individuals employed by the Company to facilitate the Service, to provide the Service on behalf of the Company, to perform services related to the Service or to assist the Company in analyzing how the Service is used.'),
//             _bulletPoint(
//                 'Third-party Social Media Service refers to any website or any social network website through which a User can log in or create an account to use the Service.'),
//             _bulletPoint(
//                 'Usage Data refers to data collected automatically, either generated by the use of the Service or from the Service infrastructure itself (for example, the duration of a page visit).'),
//             _bulletPoint(
//                 'You means the individual accessing or using the Service, or the company, or other legal entity on behalf of which such individual is accessing or using the Service, as applicable.'),
//             _sectionTitle('Collecting and Using Your Personal Data'),
//             _sectionTitle('Types of Data Collected'),
//             _sectionTitle('Personal Data'),
//             _paragraph(
//                 'While using Our Service, We may ask You to provide Us with certain personally identifiable information that can be used to contact or identify You. Personally identifiable information may include, but is not limited to:'),
//             _bulletPoint('Email address'),
//             _bulletPoint('First name and last name'),
//             _bulletPoint('Phone number'),
//             _bulletPoint('Address, State, Province, ZIP/Postal code, City'),
//             _bulletPoint('Usage Data'),
//             _sectionTitle('Usage Data'),
//             _paragraph(
//                 'Usage Data is collected automatically when using the Service. Usage Data may include information such as Your Device\'s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that You visit, the time and date of Your visit, the time spent on those pages, unique device identifiers and other diagnostic data.'),
//             _paragraph(
//                 'When You access the Service by or through a mobile device, We may collect certain information automatically, including, but not limited to, the type of mobile device You use, Your mobile device unique ID, the IP address of Your mobile device, Your mobile operating system, the type of mobile Internet browser You use, unique device identifiers and other diagnostic data.'),
//             _paragraph(
//                 'We may also collect information that Your browser sends whenever You visit our Service or when You access the Service by or through a mobile device.'),
//             _sectionTitle('Information from Third-Party Social Media Services'),
//             _paragraph(
//                 'The Company allows You to create an account and log in to use the Service through the following Third-party Social Media Services:'),
//             _bulletPoint('Google'),
//             _bulletPoint('Facebook'),
//             _bulletPoint('Instagram'),
//             _bulletPoint('Twitter'),
//             _bulletPoint('LinkedIn'),
//             _paragraph(
//                 'If You decide to register through or otherwise grant us access to a Third-Party Social Media Service, We may collect Personal data that is already associated with Your Third-Party Social Media Service\'s account, such as Your name, Your email address, Your activities or Your contact list associated with that account.'),
//             _paragraph(
//                 'You may also have the option of sharing additional information with the Company through Your Third-Party Social Media Service\'s account. If You choose to provide such information and Personal Data, during registration or otherwise, You are giving the Company permission to use, share, and store it in a manner consistent with this Privacy Policy.'),
//             _sectionTitle('Information Collected while Using the Application'),
//             _paragraph(
//                 'While using Our Application, in order to provide features of Our Application, We may collect, with Your prior permission:'),
//             _bulletPoint(
//                 'Pictures and other information from your Device\'s camera and photo library'),
//             _paragraph(
//                 'We use this information to provide features of Our Service, to improve and customize Our Service. The information may be uploaded to the Company\'s servers and/or a Service Provider\'s server or it may be simply stored on Your device.'),
//             _paragraph(
//                 'You can enable or disable access to this information at any time, through Your Device settings.'),
//             _sectionTitle('Use of Your Personal Data'),
//             _paragraph(
//                 'The Company may use Personal Data for the following purposes:'),
//             _bulletPoint(
//                 'To provide and maintain our Service, including to monitor the usage of our Service.'),
//             _bulletPoint(
//                 'To manage Your Account: to manage Your registration as a user of the Service. The Personal Data You provide can give You access to different functionalities of the Service that are available to You as a registered user.'),
//             _bulletPoint(
//                 'For the performance of a contract: the development, compliance and undertaking of the purchase contract for the products, items or services You have purchased or of any other contract with Us through the Service.'),
//             _bulletPoint(
//                 'To contact You: To contact You by email, telephone calls, SMS, or other equivalent forms of electronic communication, such as a mobile application\'s push notifications regarding updates or informative communications related to the functionalities, products or contracted services, including the security updates, when necessary or reasonable for their implementation.'),
//             _bulletPoint(
//                 'To provide You with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless You have opted not to receive such information.'),
//             _bulletPoint(
//                 'To manage Your requests: To attend and manage Your requests to Us.'),
//             _bulletPoint(
//                 'For business transfers: We may use Your information to evaluate or conduct a merger, divestiture, restructuring, reorganization, dissolution, or other sale or transfer of some or all of Our assets, whether as a going concern or as part of bankruptcy, liquidation, or similar proceeding, in which Personal Data held by Us about our Service users is among the assets transferred.'),
//             _bulletPoint(
//                 'For other purposes: We may use Your information for other purposes, such as data analysis, identifying usage trends, determining the effectiveness of our promotional campaigns and to evaluate and improve our Service, products, services, marketing and your experience.'),
//             _paragraph(
//                 'We may share Your personal information in the following situations:'),
//             _bulletPoint(
//                 'With Service Providers: We may share Your personal information with Service Providers to monitor and analyze the use of our Service, to contact You.'),
//             _bulletPoint(
//                 'For business transfers: We may share or transfer Your personal information in connection with, or during negotiations of, any merger, sale of Company assets, financing, or acquisition of all or a portion of Our business to another company.'),
//             _bulletPoint(
//                 'With Affiliates: We may share Your information with Our affiliates, in which case we will require those affiliates to honor this Privacy Policy. Affiliates include Our parent company and any other subsidiaries, joint venture partners or other companies that We control or that are under common control with Us.'),
//             _bulletPoint(
//                 'With business partners: We may share Your information with Our business partners to offer You certain products, services or promotions.'),
//             _bulletPoint(
//                 'With other users: when You share personal information or otherwise interact in the public areas with other users, such information may be viewed by all users and may be publicly distributed outside.'),
//             _bulletPoint(
//                 'With Your consent: We may disclose Your personal information for any other purpose with Your consent.'),
//             _sectionTitle('Retention of Your Personal Data'),
//             _paragraph(
//                 'The Company will retain Your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use Your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.'),
//             _paragraph(
//                 'The Company will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period of time, except when this data is used to strengthen the security or to improve the functionality of Our Service, or We are legally obligated to retain this data for longer time periods.'),
//             _sectionTitle('Transfer of Your Personal Data'),
//             _paragraph(
//                 'Your information, including Personal Data, is processed at the Company\'s operating offices and in any other places where the parties involved in the processing are located. It means that this information may be transferred to — and maintained on — computers located outside of Your state, province, country or other governmental jurisdiction where the data protection laws may differ from those of Your jurisdiction.'),
//             _paragraph(
//                 'Your consent to this Privacy Policy followed by Your submission of such information represents Your agreement to that transfer.'),
//             _paragraph(
//                 'The Company will take all steps reasonably necessary to ensure that Your data is treated securely and in accordance with this Privacy Policy and no transfer of Your Personal Data will take place to an organization or a country unless there are adequate controls in place including the security of Your data and other personal information.'),
//             _sectionTitle('Disclosure of Your Personal Data'),
//             _sectionTitle('Business Transactions'),
//             _paragraph(
//                 'If the Company is involved in a merger, acquisition or asset sale, Your Personal Data may be transferred. We will provide notice before Your Personal Data is transferred and becomes subject to a different Privacy Policy'),
//             _sectionTitle('Law enforcement'),
//             _paragraph(
//                 'Under certain circumstances, the Company may be required to disclose Your Personal Data if required to do so by law or in response to valid requests by public authorities (e.g. a court or a government agency).'),
//             _sectionTitle('Other legal requirements'),
//             _paragraph(
//                 'The Company may disclose Your Personal Data in the good faith belief that such action is necessary to:'),
//             _bulletPoint('Comply with a legal obligation'),
//             _bulletPoint(
//                 'Protect and defend the rights or property of the Company'),
//             _bulletPoint(
//                 'Prevent or investigate possible wrongdoing in connection with the Service'),
//             _bulletPoint(
//                 'Protect the personal safety of Users of the Service or the public'),
//             _bulletPoint('Protect against legal liability'),
//             _sectionTitle('Security of Your Personal Data'),
//             _paragraph(
//                 'The security of Your Personal Data is important to Us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While We strive to use commercially acceptable means to protect Your Personal Data, We cannot guarantee its absolute security.'),
//             _sectionTitle('Children\'s Privacy'),
//             _paragraph(
//                 'Our Service does not address anyone under the age of 13. We do not knowingly collect personally identifiable information from anyone under the age of 13. If You are a parent or guardian and You are aware that Your child has provided Us with Personal Data, please contact Us. If We become aware that We have collected Personal Data from anyone under the age of 13 without verification of parental consent, We take steps to remove that information from Our servers.'),
//             _paragraph(
//                 'If We need to rely on consent as a legal basis for processing Your information and Your country requires consent from a parent, We may require Your parent\'s consent before We collect and use that information.'),
//             _sectionTitle('Links to Other Websites'),
//             _paragraph(
//                 'Our Service may contain links to other websites that are not operated by Us. If You click on a third party link, You will be directed to that third party\'s site. We strongly advise You to review the Privacy Policy of every site You visit.'),
//             _paragraph(
//                 'We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.'),
//             _sectionTitle('Changes to this Privacy Policy'),
//             _paragraph(
//                 'We may update Our Privacy Policy from time to time. We will notify You of any changes by posting the new Privacy Policy on this page.'),
//             _paragraph(
//                 'We will let You know via email and/or a prominent notice on Our Service, prior to the change becoming effective and update the "Last updated" date at the top of this Privacy Policy.'),
//             _paragraph(
//                 'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.'),
//             _sectionTitle('Contact Us'),
//             _paragraph(
//                 'If you have any questions about this Privacy Policy, You can contact us:'),
//             _bulletPoint('By email: teledoc00@gmail.com'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//       ),
//     );
//   }

//   Widget _paragraph(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 16),
//       ),
//     );
//   }

//   Widget _bulletPoint(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text('• ', style: TextStyle(fontSize: 16)),
//           Expanded(
//             child: Text(
//               text,
//               style: const TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  // ignore: library_private_types_in_public_api
  PrivacyPolicyState createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://sites.google.com/view/febinnoufan/home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   automaticallyImplyLeading: false,
      //   toolbarHeight: 100,
      //   title: const Text(
      //     'Privacy Policy',
      //     style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: WebViewWidget(controller: _controller),
    );
  }
}