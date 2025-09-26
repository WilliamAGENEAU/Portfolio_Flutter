import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_flutter/values/values.dart';
import 'package:portfolio_flutter/sections/pages/project_detail_page.dart';
import 'package:portfolio_flutter/widgets/project_item.dart';
import 'package:visibility_detector/visibility_detector.dart';

class GalleryGuirlande extends StatefulWidget {
  final List<String> images;
  final List<ProjectItemData>? projects; // optional mapping for taps

  const GalleryGuirlande({required this.images, this.projects, super.key});

  @override
  State<GalleryGuirlande> createState() => _GalleryGuirlandeState();
}

class _GalleryGuirlandeState extends State<GalleryGuirlande> {
  bool _galleryVisible = false;
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
      color: Color(0xff171014),
      child: VisibilityDetector(
        key: const Key('gallery-visibility'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.3 && !_galleryVisible) {
            setState(() {
              _galleryVisible = true;
            });
          }
        },
        child: Align(
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bool isMobile = constraints.maxWidth < 700;
              final double baseImageSize = isMobile ? 90 : 160;
              final double minSpacing = isMobile ? 8 : 12;
              int itemCount = widget.images.length;
              double availableWidth = constraints.maxWidth;
              double imageWidth = baseImageSize + 40;
              // Compute gap and scale image width to guarantee fit
              final double minRequiredWidth =
                  (baseImageSize * itemCount) + (minSpacing * (itemCount - 1));
              if (minRequiredWidth > availableWidth) {
                final double scale = availableWidth / minRequiredWidth;
                imageWidth = baseImageSize * scale;
                // gaps handled by spaceBetween; scaling ensures fit
              }

              // Offsets for 6-item garland, subtle wave
              final List<double> customOffsets = [
                -20.0,
                12.0,
                -28.0,
                20.0,
                -16.0,
                10.0,
              ];
              // Note: gaps handled via spaceBetween; images scaled to guarantee fit

              if (isMobile) {
                // Mobile: grille centrée
                return SizedBox(
                  height: baseImageSize * 2.5 + 40,
                  width: constraints.maxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: minSpacing,
                        runSpacing: minSpacing * 2,
                        children: List.generate(itemCount, (index) {
                          return _HoverZoomImage(
                            imagePath: widget.images[index],
                            offsetY: 0,
                            imageSize: baseImageSize,
                            onTap: () => _onImageTap(context, index),
                            isActive: _hoveredIndex == index,
                            onHoverChanged: (hovering) {
                              setState(() {
                                _hoveredIndex = hovering ? index : -1;
                              });
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                );
              } else {
                // Desktop/tablette: guirlande animée
                return SizedBox(
                  height: imageWidth * 2.6 + 180,
                  width: constraints.maxWidth,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: _galleryVisible
                        ? AnimationLimiter(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(itemCount, (index) {
                                final widgetImage = _HoverZoomImage(
                                  imagePath: widget.images[index],
                                  offsetY:
                                      customOffsets[index %
                                          customOffsets.length],
                                  imageSize: imageWidth,
                                  onTap: () => _onImageTap(context, index),
                                  isActive: _hoveredIndex == index,
                                  onHoverChanged: (hovering) {
                                    setState(() {
                                      _hoveredIndex = hovering ? index : -1;
                                    });
                                  },
                                );
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 600),
                                  child: SlideAnimation(
                                    verticalOffset: 60.0,
                                    child: FadeInAnimation(
                                      child: SizedBox(
                                        width: imageWidth,
                                        child: widgetImage,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  // Single hover active state handled inline where used now

  void _onImageTap(BuildContext context, int index) {
    // Map tap to the corresponding project if provided; otherwise fallback to 4-sample order
    final List<ProjectItemData> dataSource =
        widget.projects ??
        [
          Projects.ELEVAGEY,
          Projects.MARVEL,
          Projects.MUSEUM_EDIBLE_EARTH,
          Projects.CONNECTED_CHESSBOARD,
          Projects.MOTION_DESIGN,
          Projects.INAZUMA,
        ];
    final int clampedIndex = index % dataSource.length;
    final ProjectItemData project = dataSource[clampedIndex];

    final int projectIndex = clampedIndex;
    final bool hasNextProject = projectIndex < dataSource.length - 1;
    final ProjectItemData? nextProject = hasNextProject
        ? dataSource[projectIndex + 1]
        : null;

    Navigator.pushNamed(
      context,
      StringConst.PROJECT_DETAIL_PAGE,
      arguments: ProjectDetailArguments(
        dataSource: dataSource,
        data: project,
        currentIndex: projectIndex,
        hasNextProject: hasNextProject,
        nextProject: nextProject,
      ),
    );
  }
}

class _HoverZoomImage extends StatefulWidget {
  final String imagePath;
  final double offsetY;
  final double imageSize;
  final VoidCallback onTap;
  final bool isActive;
  final ValueChanged<bool> onHoverChanged;

  const _HoverZoomImage({
    required this.imagePath,
    required this.offsetY,
    required this.imageSize,
    required this.onTap,
    required this.isActive,
    required this.onHoverChanged,
  });

  @override
  State<_HoverZoomImage> createState() => _HoverZoomImageState();
}

class _HoverZoomImageState extends State<_HoverZoomImage> {
  @override
  Widget build(BuildContext context) {
    final bool showColor = widget.isActive;
    return Transform.translate(
      offset: Offset(0, widget.offsetY),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: MouseRegion(
          onEnter: (_) => widget.onHoverChanged(true),
          onExit: (_) => widget.onHoverChanged(false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedScale(
              scale: showColor ? 1.13 : 1.0,
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              child: ClipRRect(
                // Tube shape: rounded capsule, taller than wide
                borderRadius: BorderRadius.circular(widget.imageSize),
                child: ColorFiltered(
                  colorFilter: showColor
                      ? const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.multiply,
                        )
                      : const ColorFilter.matrix([
                          // Matrice noir et blanc/beige
                          0.36, 0.54, 0.10, 0, 30, // R
                          0.36, 0.54, 0.10, 0, 24, // G
                          0.36, 0.54, 0.10, 0, 12, // B
                          0, 0, 0, 1, 0, // A
                        ]),
                  child: Image.asset(
                    widget.imagePath,
                    width: widget.imageSize,
                    height: widget.imageSize * 2.6,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
