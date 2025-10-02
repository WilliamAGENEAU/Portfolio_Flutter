// ignore_for_file: library_private_types_in_public_api

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio_flutter/core/extensions.dart';
import 'package:portfolio_flutter/widgets/animated_positioned_widget.dart';

import '../../core/adaptive.dart';
import '../../values/values.dart';
import '../../widgets/aerium_button.dart';
import '../../widgets/animated_positioned_text.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/page_wrapper.dart';
import '../../widgets/simple_footer.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        _controller.forward();
      });
    });

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
    // Use persistent controllers already defined for a consistent UX
    final TextEditingController emailController = _emailController;
    final TextEditingController messageController = _messageController;
    final TextEditingController firstNameController = _nameController;
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController subjectController = _subjectController;
    TextTheme textTheme = Theme.of(context).textTheme;

    double contentAreaWidth = responsiveSize(
      context,
      assignWidth(context, 0.9),
      assignWidth(context, 0.65),
    );

    // Remonte le padding top pour placer le form plus haut
    EdgeInsetsGeometry padding = EdgeInsets.only(
      left: responsiveSize(
        context,
        assignWidth(context, 0.06),
        assignWidth(context, 0.10),
      ),
      right: responsiveSize(
        context,
        assignWidth(context, 0.06),
        assignWidth(context, 0.10),
      ),
      top: responsiveSize(
        context,
        assignHeight(context, 0.06),
        assignHeight(context, 0.10),
      ),
    );
    TextStyle? headingStyle = textTheme.bodyLarge?.copyWith(
      color: AppColors.white,
      fontSize: responsiveSize(context, 40, 60),
    );

    return PageWrapper(
      selectedRoute: ContactPage.contactPageRoute,
      selectedPageName: "",
      navBarAnimationController: _controller,
      appLogoColor: AppColors.white,
      onLoadingAnimationDone: () {
        _controller.forward();
      },
      child: Container(
        color: const Color(0xff171014),
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            Padding(
              padding: padding,
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: ContentArea(
                    width: contentAreaWidth,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Titre principal
                              FadeTransition(
                                opacity: _controller,
                                child: SlideTransition(
                                  position:
                                      Tween<Offset>(
                                        begin: const Offset(
                                          0,
                                          0.3,
                                        ), // décalage initial
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: _controller,
                                          curve: Curves.easeOut,
                                        ),
                                      ),
                                  child: AutoSizeText(
                                    "ENTRONS EN CONTACT !",
                                    maxLines: 1,
                                    style: headingStyle,

                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              CustomSpacer(heightFactor: 0.03),
                              // Sous-titre
                              AnimatedPositionedText(
                                width: contentAreaWidth * 0.9,
                                controller: CurvedAnimation(
                                  parent: _controller,
                                  curve: const Interval(
                                    0.6,
                                    1.0,
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                ),
                                text:
                                    "N'HÉSITEZ PAS À ME CONTACTER POUR DE FUTURS PROJETS ET OPPORTUNITÉ.",
                                maxLines: 3,
                                textStyle: textTheme.bodyLarge?.copyWith(
                                  color: Colors.white70,
                                  height: 1.8,
                                  fontSize: responsiveSize(
                                    context,
                                    Sizes.TEXT_SIZE_16,
                                    Sizes.TEXT_SIZE_18,
                                  ),
                                ),
                              ),
                              CustomSpacer(heightFactor: 0.05),
                              // Formulaire
                              Theme(
                                data: Theme.of(context).copyWith(
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                        labelStyle: TextStyle(
                                          color: Colors.white70,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.white54,
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white54,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                          ),
                                        ),
                                        errorBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                      ),
                                ),
                                child: AnimatedPositionedWidget(
                                  controller: CurvedAnimation(
                                    parent: _controller,
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                  width: contentAreaWidth,
                                  height: MediaQuery.of(
                                    context,
                                  ).size.height, // ✅ taille écran
                                  child: Form(
                                    key: _formKey,
                                    child: LayoutBuilder(
                                      builder: (context, constraints) {
                                        final bool isNarrow =
                                            constraints.maxWidth < 820;
                                        final double fieldWidth = isNarrow
                                            ? constraints.maxWidth
                                            : (constraints.maxWidth - 40) / 2;

                                        return SingleChildScrollView(
                                          // ✅ permet de scroller sur mobile
                                          child: Wrap(
                                            spacing: 40,
                                            runSpacing: isNarrow ? 22 : 28,
                                            children: [
                                              SizedBox(
                                                width: fieldWidth,
                                                child: TextFormField(
                                                  controller:
                                                      firstNameController,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration:
                                                      const InputDecoration(
                                                        labelText: "Prénom",
                                                      ),
                                                  onChanged: isNameValid,
                                                ),
                                              ),
                                              SizedBox(
                                                width: fieldWidth,
                                                child: TextFormField(
                                                  controller:
                                                      lastNameController,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration:
                                                      const InputDecoration(
                                                        labelText:
                                                            "Nom de famille",
                                                      ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: fieldWidth,
                                                child: TextFormField(
                                                  controller: emailController,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                    labelText: "E-mail *",
                                                    errorText: _emailError,
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Veuillez entrer votre e-mail";
                                                    }
                                                    if (!RegExp(
                                                      r'^[^@]+@[^@]+\.[^@]+',
                                                    ).hasMatch(value)) {
                                                      return "Veuillez entrer un e-mail valide";
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: isEmailValid,
                                                ),
                                              ),
                                              SizedBox(
                                                width: fieldWidth,
                                                child: TextFormField(
                                                  controller: subjectController,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration:
                                                      const InputDecoration(
                                                        labelText: "Objet",
                                                      ),
                                                  onChanged: isSubjectValid,
                                                ),
                                              ),
                                              SizedBox(
                                                width: constraints.maxWidth,
                                                child: TextFormField(
                                                  controller: messageController,
                                                  maxLines: 8,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        "Laissez-moi un message...",
                                                    errorText: _messageError,
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return "Veuillez entrer votre message";
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: isMessageValid,
                                                ),
                                              ),
                                              // ✅ Bouton toujours visible
                                              SizedBox(
                                                width: constraints.maxWidth,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: AeriumButton(
                                                    title: "Envoyer",
                                                    isLoading: _isSending,
                                                    onPressed: _isSending
                                                        ? null
                                                        : () async {
                                                            if (_formKey
                                                                .currentState!
                                                                .validate()) {
                                                              await sendFormspree(
                                                                emailController
                                                                    .text,
                                                                messageController
                                                                    .text,
                                                              );
                                                            }
                                                          },
                                                  ),
                                                ),
                                              ),
                                              if (_sent)
                                                SizedBox(
                                                  width: constraints.maxWidth,
                                                  child: const Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 16.0,
                                                    ),
                                                    child: Text(
                                                      "Message envoyé ! Merci.",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ), // ConstrainedBox
              ), // Align
            ), // Padding
            CustomSpacer(heightFactor: 0.15),
            SimpleFooter(),
          ],
        ),
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
