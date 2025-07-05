// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_flutter/core/extensions.dart';

import '../../core/adaptive.dart';
import '../../values/values.dart';
import '../../widgets/aerium_button.dart';
import '../../widgets/animated_positioned_text.dart';
import '../../widgets/animated_text_slide_box_transition.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/page_wrapper.dart';
import '../../widgets/simple_footer.dart';
import '../../widgets/spaces.dart';

class ContactPage extends StatefulWidget {
  static const String contactPageRoute = StringConst.CONTACT_PAGE;
  const ContactPage({super.key});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isSendingEmail = false;
  bool isBodyVisible = false;
  bool _nameFilled = false;
  bool _emailFilled = false;
  bool _subjectFilled = false;
  bool _messageFilled = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isSending = false;
  bool _sent = false;
  String? _emailError;
  String? _messageError;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Animations.slideAnimationDurationLong,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isFormValid() {
    return _nameFilled && _subjectFilled && _messageFilled && _emailFilled;
  }

  void sendEmail() {
    if (isFormValid()) {
      setState(() {
        isSendingEmail = true;
      });
    } else {
      isNameValid(_nameController.text);
      isEmailValid(_emailController.text);
      isSubjectValid(_subjectController.text);
      isMessageValid(_messageController.text);
    }
  }

  Future<void> sendFormspree(String email, String message) async {
    setState(() {
      _isSending = true;
      _sent = false;
      _emailError = null;
      _messageError = null;
    });
    final uri = Uri.parse('https://formspree.io/f/mpwreqpy');
    final response = await http.post(
      uri,
      headers: {'Accept': 'application/json'},
      body: {'email': email, 'message': message},
    );
    setState(() {
      _isSending = false;
      if (response.statusCode == 200) {
        _sent = true;
      } else {
        _sent = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController messageController = TextEditingController();
    TextTheme textTheme = Theme.of(context).textTheme;

    double contentAreaWidth = responsiveSize(
      context,
      assignWidth(context, 0.8),
      assignWidth(context, 0.6),
    );

    // Remonte le padding top pour placer le form plus haut
    EdgeInsetsGeometry padding = EdgeInsets.only(
      left: responsiveSize(
        context,
        assignWidth(context, 0.10),
        assignWidth(context, 0.15),
      ),
      right: responsiveSize(
        context,
        assignWidth(context, 0.10),
        assignWidth(context, 0.25),
      ),
      top: responsiveSize(
        context,
        assignHeight(context, 0.08), // Était 0.25, maintenant plus haut
        assignHeight(context, 0.12),
      ),
    );
    TextStyle? headingStyle = textTheme.bodyLarge?.copyWith(
      color: AppColors.black,
      fontSize: responsiveSize(context, 40, 60),
    );

    return PageWrapper(
      selectedRoute: ContactPage.contactPageRoute,
      selectedPageName: "",
      navBarAnimationController: _controller,
      onLoadingAnimationDone: () {
        _controller.forward();
      },
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Padding(
            padding: padding,
            child: ContentArea(
              width: contentAreaWidth,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FORMULAIRE (2/3)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedTextSlideBoxTransition(
                          controller: _controller,
                          text: StringConst.GET_IN_TOUCH,
                          textStyle: headingStyle,
                          color: AppColors.background,
                        ),
                        CustomSpacer(heightFactor: 0.03),
                        AnimatedPositionedText(
                          width: contentAreaWidth * 0.66,
                          controller: CurvedAnimation(
                            parent: _controller,
                            curve: Interval(
                              0.6,
                              1.0,
                              curve: Curves.fastOutSlowIn,
                            ),
                          ),
                          text: StringConst.CONTACT_MSG,
                          maxLines: 5,
                          textStyle: textTheme.bodyLarge?.copyWith(
                            color: AppColors.grey700,
                            height: 2.0,
                            fontSize: responsiveSize(
                              context,
                              Sizes.TEXT_SIZE_16,
                              Sizes.TEXT_SIZE_18,
                            ),
                          ),
                        ),
                        CustomSpacer(heightFactor: 0.03),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                width:
                                    contentAreaWidth *
                                    0.66, // Réduit la largeur du champ
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Your email",
                                    errorText: _emailError,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your email";
                                    }
                                    if (!RegExp(
                                      r'^[^@]+@[^@]+\.[^@]+',
                                    ).hasMatch(value)) {
                                      return "Please enter a valid email";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SpaceH20(),
                              SizedBox(
                                width: contentAreaWidth * 0.66,
                                child: TextFormField(
                                  controller: messageController,
                                  maxLines: 8,
                                  decoration: InputDecoration(
                                    labelText: "Your message",
                                    errorText: _messageError,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please enter your message";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SpaceH20(),
                              Align(
                                alignment: Alignment.topRight,
                                child: AeriumButton(
                                  title: "Send",
                                  isLoading: _isSending,
                                  onPressed: _isSending
                                      ? null
                                      : () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            await sendFormspree(
                                              emailController.text,
                                              messageController.text,
                                            );
                                          }
                                        },
                                ),
                              ),
                              if (_sent)
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Text(
                                    "Message sent! Thank you.",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ESPACE DROITE (1/3)
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
          ),
          CustomSpacer(heightFactor: 0.15),
          SimpleFooter(),
        ],
      ),
    );
  }

  bool isTextValid(String value) {
    if (value.isNotEmpty) {
      return true;
    }
    return false;
  }

  void isNameValid(String name) {
    bool isValid = isTextValid(name);
    setState(() {
      _nameFilled = isValid;
    });
  }

  void isEmailValid(String email) {
    bool isValid = email.isValidEmail();
    setState(() {
      _emailFilled = isValid;
    });
  }

  void isSubjectValid(String subject) {
    bool isValid = isTextValid(subject);
    setState(() {
      _subjectFilled = isValid;
    });
  }

  void isMessageValid(String message) {
    bool isValid = isTextValid(message);
    setState(() {
      _messageFilled = isValid;
    });
  }

  void clearText() {
    _nameController.text = "";
    _emailController.text = "";
    _subjectController.text = "";
    _messageController.text = "";
  }
}
