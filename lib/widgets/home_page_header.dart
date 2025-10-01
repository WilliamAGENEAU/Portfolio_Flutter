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

class _HomePageHeaderState extends State<HomePageHeader> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset("assets/videos/braise.mp4")
      ..initialize().then((_) {
        setState(() => _isVideoInitialized = true);
        _videoController
          ..setLooping(true)
          ..setVolume(0)
          ..play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = widthOfScreen(context);
    final double screenHeight = heightOfScreen(context);

    return SizedBox(
      width: screenWidth,
      height: screenHeight + 60,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Vidéo en background
          if (_isVideoInitialized)
            FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: _videoController.value.size.width,
                height: _videoController.value.size.height,
                child: VideoPlayer(_videoController),
              ),
            )
          else
            Container(color: Colors.black),

          // // Dégradé vers le bas
          // Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [Colors.transparent, Color(0xff171014)],
          //       stops: [0.96, 1.0], // commence à 70% de la hauteur
          //     ),
          //   ),
          // ),

          // Contenu par-dessus
          ResponsiveBuilder(
            builder: (context, sizingInformation) {
              final bool isMobile =
                  sizingInformation.screenSize.width <
                  RefinedBreakpoints().tabletNormal;

              final Widget titleBlock = Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "INGÉNIEUR FRONT-END, IOT, MOBILE, UX/UI DESIGNER",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.white.withOpacity(0.8),
                      letterSpacing: 1.2,
                      fontSize: 20,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "WILLIAM",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.white,
                      fontSize: isMobile ? 48 : 110,
                      fontWeight: FontWeight.w800,
                      height: 0.95,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                  Text(
                    "AGENEAU",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.white,
                      fontSize: isMobile ? 48 : 110,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                      height: 0.95,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: isMobile ? screenWidth * 0.85 : screenWidth * 0.45,
                    child: Text(
                      "Je suis ingénieur front-end spécialisé en Flutter avec un fort intérêt pour le design UX/UI et l’IoT.",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white.withOpacity(0.9),
                      ),
                      textAlign: isMobile ? TextAlign.center : TextAlign.left,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Bloc projet récent
                  if (!isMobile)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _FramedProjectCard(imagePath: ImagePath.MARVEL_RECENT),
                        const SizedBox(width: 28),
                        _RecentProjectInfo(
                          onOpen: () {
                            final int index = Data.projects.indexOf(
                              Projects.MARVEL,
                            );
                            Functions.navigateToProject(
                              context: context,
                              dataSource: Data.projects,
                              currentProject: Projects.MARVEL,
                              currentProjectIndex: index < 0 ? 0 : index,
                            );
                          },
                        ),
                      ],
                    ),
                ],
              );

              if (isMobile) {
                return Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 90.0,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      children: [
                        titleBlock,
                        const SizedBox(height: 24),
                        _FramedProjectCard(imagePath: ImagePath.MARVEL_BKG),
                        const SizedBox(height: 16),
                        _RecentProjectInfo(
                          onOpen: () {
                            final int index = Data.projects.indexOf(
                              Projects.MARVEL,
                            );
                            Functions.navigateToProject(
                              context: context,
                              dataSource: Data.projects,
                              currentProject: Projects.MARVEL,
                              currentProjectIndex: index < 0 ? 0 : index,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Desktop/tablette
              return Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 72.0),
                  child: titleBlock,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FramedProjectCard extends StatelessWidget {
  const _FramedProjectCard({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      height: 320,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            offset: const Offset(0, 14),
            blurRadius: 40,
            spreadRadius: -10,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [Image.asset(imagePath, fit: BoxFit.cover)],
      ),
    );
  }
}

class _RecentProjectInfo extends StatefulWidget {
  const _RecentProjectInfo({required this.onOpen});

  final VoidCallback onOpen;

  @override
  State<_RecentProjectInfo> createState() => _RecentProjectInfoState();
}

class _RecentProjectInfoState extends State<_RecentProjectInfo> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    const Duration hoverDuration = Duration(milliseconds: 220);
    const Curve hoverCurve = Curves.easeOutCubic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 64),
        Text(
          "Projet récent",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.white.withOpacity(0.9),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          "Marvel Cinematic Universe | Flutter | 2025",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 22),
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
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: AppColors.white),
                ),
                const SizedBox(width: 12),
                AnimatedContainer(
                  duration: hoverDuration,
                  curve: hoverCurve,
                  width: _hovering ? 40 : 36,
                  height: _hovering ? 40 : 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _hovering
                          ? AppColors.white
                          : AppColors.white.withOpacity(0.6),
                      width: _hovering ? 2 : 1.2,
                    ),
                    boxShadow: _hovering
                        ? [
                            BoxShadow(
                              color: AppColors.white.withOpacity(0.45),
                              blurRadius: 18,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                    color: _hovering
                        ? const Color(0x1A7CFF6B)
                        : Colors.transparent,
                  ),
                  child: AnimatedPadding(
                    duration: hoverDuration,
                    curve: hoverCurve,
                    padding: EdgeInsets.only(left: _hovering ? 6 : 0),
                    child: Center(
                      child: Icon(
                        Icons.arrow_forward,
                        color: _hovering ? AppColors.white : Colors.white,
                        size: _hovering ? 22 : 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
