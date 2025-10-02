// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';

import '../core/adaptive.dart';
import '../core/functions.dart';
import '../values/values.dart';

class HomePageHeader extends StatefulWidget {
  const HomePageHeader({
    super.key,
    required this.scrollToWorksKey,
    required this.controller,
  });

  final GlobalKey scrollToWorksKey;
  final AnimationController controller;

  @override
  _HomePageHeaderState createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _videoController = VideoPlayerController.asset("assets/videos/braise.mp4")
      ..initialize().then((_) {
        setState(() => _isVideoInitialized = true);
        _videoController
          ..setLooping(true)
          ..setVolume(0)
          ..play();
        _fadeController.forward();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = widthOfScreen(context);
    final double screenHeight = heightOfScreen(context);

    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final bool isMobile =
            sizingInformation.screenSize.width <
            RefinedBreakpoints().tabletNormal;

        return SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Vidéo en background
              if (_isVideoInitialized)
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: isMobile
                      ? Positioned.fill(
                          child: Transform.translate(
                            offset: Offset(-screenWidth * 0.25, 0),
                            child: Transform.scale(
                              scale: 1.5,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                clipBehavior: Clip.hardEdge,
                                child: SizedBox(
                                  width: _videoController.value.size.width,
                                  height: _videoController.value.size.height,
                                  child: VideoPlayer(_videoController),
                                ),
                              ),
                            ),
                          ),
                        )
                      : FittedBox(
                          fit: BoxFit.cover,
                          clipBehavior: Clip.hardEdge,
                          child: SizedBox(
                            width: _videoController.value.size.width,
                            height: _videoController.value.size.height,
                            child: VideoPlayer(_videoController),
                          ),
                        ),
                )
              else
                Container(color: Colors.black),

              // Overlay léger uniquement en bas pour la transition
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xff171014).withOpacity(0.3),
                        const Color(0xff171014),
                      ],
                      stops: const [0.0, 0.7, 1.0],
                    ),
                  ),
                ),
              ),

              // Contenu
              SafeArea(
                child: isMobile
                    ? _buildMobileLayout(context, screenWidth, screenHeight)
                    : _buildDesktopLayout(context, screenWidth),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Titre et sous-titre
          _buildTitleBlock(context, isMobile: true),
          const Spacer(),
          // Carte projet et info
          _FramedProjectCard(
            imagePath: ImagePath.MARVEL_BKG,
            width: screenWidth * 0.65,
            height: screenWidth * 0.88,
          ),
          const SizedBox(height: 20),
          _RecentProjectInfo(
            isMobile: true,
            onOpen: () => _navigateToProject(context),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 72.0, vertical: 60),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SingleChildScrollView(
          // ✅ Ajout scroll si contenu > hauteur
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // ✅ reste compact
            children: [
              _buildTitleBlock(context, isMobile: false),
              const SizedBox(height: 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FramedProjectCard(
                    imagePath: ImagePath.MARVEL_RECENT,
                    width: 240,
                    height: 320,
                  ),
                  const SizedBox(width: 28),
                  Expanded(
                    child: _RecentProjectInfo(
                      isMobile: false,
                      onOpen: () => _navigateToProject(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleBlock(BuildContext context, {required bool isMobile}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: isMobile ? const EdgeInsets.all(16) : EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "INGÉNIEUR FRONT-END, IOT, MOBILE, UX/UI DESIGNER",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.white.withOpacity(0.95),
                letterSpacing: 1.2,
                fontSize: isMobile ? 11 : 20,
                fontWeight: FontWeight.w600,
                shadows: isMobile
                    ? [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            SizedBox(height: isMobile ? 16 : 16),
            Text(
              "WILLIAM",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.white,
                fontSize: isMobile ? 52 : 110,
                fontWeight: FontWeight.w800,
                height: 1.0,
                letterSpacing: -1,
                shadows: isMobile
                    ? [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ]
                    : null,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            Text(
              "AGENEAU",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: AppColors.white,
                fontSize: isMobile ? 52 : 110,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
                height: 1.0,
                letterSpacing: -1,
                shadows: isMobile
                    ? [
                        Shadow(
                          color: Colors.black.withOpacity(0.6),
                          offset: const Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ]
                    : null,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.left,
            ),
            SizedBox(height: isMobile ? 16 : 24),
            SizedBox(
              width: isMobile ? double.infinity : widthOfScreen(context) * 0.45,
              child: Text(
                "Je suis ingénieur front-end spécialisé en Flutter avec un fort intérêt pour le design UX/UI et l'IoT.",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.white.withOpacity(0.95),
                  fontSize: isMobile ? 15 : 18,
                  height: 1.5,
                  shadows: isMobile
                      ? [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ]
                      : null,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProject(BuildContext context) {
    final int index = Data.projects.indexOf(Projects.MARVEL);
    Functions.navigateToProject(
      context: context,
      dataSource: Data.projects,
      currentProject: Projects.MARVEL,
      currentProjectIndex: index < 0 ? 0 : index,
    );
  }
}

class _FramedProjectCard extends StatelessWidget {
  const _FramedProjectCard({
    required this.imagePath,
    required this.width,
    required this.height,
  });

  final String imagePath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1400),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(scale: 0.9 + (0.1 * value), child: child),
        );
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              offset: const Offset(0, 20),
              blurRadius: 40,
              spreadRadius: -5,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}

class _RecentProjectInfo extends StatefulWidget {
  const _RecentProjectInfo({required this.onOpen, required this.isMobile});

  final VoidCallback onOpen;
  final bool isMobile;

  @override
  State<_RecentProjectInfo> createState() => _RecentProjectInfoState();
}

class _RecentProjectInfoState extends State<_RecentProjectInfo> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    const Duration hoverDuration = Duration(milliseconds: 220);
    const Curve hoverCurve = Curves.easeOutCubic;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1600),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: widget.isMobile ? const EdgeInsets.all(16) : EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: widget.isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (!widget.isMobile) const SizedBox(height: 64),
            Text(
              "Projet récent",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.white.withOpacity(0.95),
                fontWeight: FontWeight.w700,
                fontSize: widget.isMobile ? 14 : 16,
                shadows: widget.isMobile
                    ? [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
              textAlign: widget.isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              "Marvel Cinematic Universe",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
                fontSize: widget.isMobile ? 18 : 24,
                shadows: widget.isMobile
                    ? [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
              textAlign: widget.isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 6),
            Text(
              "Flutter | 2025",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.white.withOpacity(0.85),
                fontSize: widget.isMobile ? 14 : 16,
                shadows: widget.isMobile
                    ? [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
              textAlign: widget.isMobile ? TextAlign.center : TextAlign.left,
            ),
            const SizedBox(height: 20),
            MouseRegion(
              onEnter: (_) => setState(() => _hovering = true),
              onExit: (_) => setState(() => _hovering = false),
              child: InkWell(
                onTap: widget.onOpen,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Voir l'appli",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: widget.isMobile ? 16 : 18,
                        shadows: widget.isMobile
                            ? [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedContainer(
                      duration: hoverDuration,
                      curve: hoverCurve,
                      width: _hovering ? 44 : 40,
                      height: _hovering ? 44 : 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _hovering
                              ? AppColors.white
                              : AppColors.white.withOpacity(0.7),
                          width: _hovering ? 2.5 : 1.5,
                        ),
                        boxShadow: [
                          if (_hovering)
                            BoxShadow(
                              color: AppColors.white.withOpacity(0.5),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                          if (widget.isMobile)
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              offset: const Offset(0, 3),
                              blurRadius: 6,
                            ),
                        ],
                        color: _hovering
                            ? const Color(0x2A7CFF6B)
                            : Colors.transparent,
                      ),
                      child: AnimatedPadding(
                        duration: hoverDuration,
                        curve: hoverCurve,
                        padding: EdgeInsets.only(left: _hovering ? 6 : 0),
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                            size: _hovering ? 24 : 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
