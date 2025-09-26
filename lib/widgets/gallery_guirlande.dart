import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_flutter/values/values.dart';
import 'package:portfolio_flutter/sections/pages/project_detail_page.dart';
import 'package:portfolio_flutter/widgets/project_item.dart';
import 'package:visibility_detector/visibility_detector.dart';

class GalleryGuirlande extends StatefulWidget {
  final List<String> images;

  const GalleryGuirlande({required this.images, super.key});

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
      child: Stack(
        children: [
          VisibilityDetector(
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
                  final double imageSize = isMobile ? 90 : 160;
                  final double minSpacing = isMobile ? 8 : 16;
                  int itemCount = widget.images.length;
                  double totalImagesWidth = itemCount * imageSize;
                  double availableWidth = constraints.maxWidth;
                  double spacing =
                      (availableWidth - totalImagesWidth) / (itemCount);
                  spacing = spacing.clamp(minSpacing, imageSize * 1.2);

                  final offsets = [0.0, -38.0, 28.0, -44.0, 38.0, -32.0, 44.0];
                  List<double> customOffsets = List.from(offsets);
                  if (widget.images.length >= 6) {
                    customOffsets[5] = -12.0;
                  }
                  double rowWidth =
                      totalImagesWidth + spacing * (itemCount - 1);

                  if (isMobile) {
                    // Mobile: grille centrée
                    return SizedBox(
                      height: imageSize * 2.5 + 40,
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
                                imageSize: imageSize,
                                onTap: () => _onImageTap(context, index),
                                isActive: _isImageActive(index, _hoveredIndex),
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
                      height: imageSize + 340,
                      width: constraints.maxWidth,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: imageSize + 380,
                            width: rowWidth,
                            child: _galleryVisible
                                ? AnimationLimiter(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: itemCount,
                                      itemBuilder: (context, index) {
                                        return AnimationConfiguration.staggeredList(
                                          position: index,
                                          duration: const Duration(
                                            milliseconds: 600,
                                          ),
                                          child: SlideAnimation(
                                            verticalOffset: 60.0,
                                            child: FadeInAnimation(
                                              child: _HoverZoomImage(
                                                imagePath: widget.images[index],
                                                offsetY:
                                                    customOffsets[index %
                                                        customOffsets.length],
                                                imageSize: imageSize,
                                                onTap: () =>
                                                    _onImageTap(context, index),
                                                isActive: _isImageActive(
                                                  index,
                                                  _hoveredIndex,
                                                ),
                                                onHoverChanged: (hovering) {
                                                  setState(() {
                                                    _hoveredIndex = hovering
                                                        ? index
                                                        : -1;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Positioned(right: 32, bottom: 45, child: _WorksButton()),
        ],
      ),
    );
  }

  // Ajoute cette méthode dans _HomePageState :
  bool _isImageActive(int index, int hovered) {
    if (hovered == -1) return false;
    if ((hovered == 0 && index == 0) ||
        (hovered == 6 && index == 6) ||
        (hovered == 0 && index == 6) ||
        (hovered == 6 && index == 0)) {
      return true;
    }
    if ((hovered == 1 && index == 1) ||
        (hovered == 5 && index == 5) ||
        (hovered == 1 && index == 5) ||
        (hovered == 5 && index == 1)) {
      return true;
    }
    if ((hovered == 2 && index == 2) ||
        (hovered == 4 && index == 4) ||
        (hovered == 2 && index == 4) ||
        (hovered == 4 && index == 2)) {
      return true;
    }
    if (hovered == 3 && index == 3) return true;
    return false;
  }

  void _onImageTap(BuildContext context, int index) {
    // Détermine le projet cible selon l'index
    ProjectItemData project;
    if (index == 0 || index == 6) {
      project = Projects.MARVEL;
    } else if (index == 1 || index == 5) {
      project = Projects.CONNECTED_CHESSBOARD;
    } else if (index == 2 || index == 4) {
      project = Projects.MOTION_DESIGN;
    } else {
      project = Projects.MUSEUM_EDIBLE_EARTH;
    }

    // Liste de tous les projets utilisés dans la galerie
    final List<ProjectItemData> dataSource = [
      Projects.MUSEUM_EDIBLE_EARTH,
      Projects.CONNECTED_CHESSBOARD,
      Projects.MOTION_DESIGN,
      Projects.MARVEL,
    ];

    // Trouve l'index du projet courant dans la dataSource
    int projectIndex = dataSource.indexOf(project);

    // Détermine s'il y a un projet suivant
    bool hasNextProject = projectIndex < dataSource.length - 1;
    ProjectItemData? nextProject = hasNextProject
        ? dataSource[projectIndex + 1]
        : null;

    // Navigation avec tous les arguments requis
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
        padding: EdgeInsets.symmetric(horizontal: 18.0),
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
                borderRadius: BorderRadius.circular(widget.imageSize / 2),
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
                    height: widget.imageSize,
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

// Ajoute ce widget à la fin de ton fichier :
class _WorksButton extends StatefulWidget {
  @override
  State<_WorksButton> createState() => _WorksButtonState();
}

class _WorksButtonState extends State<_WorksButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, StringConst.WORKS_PAGE);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Works",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 220),
              margin: EdgeInsets.only(left: 12, right: _hovering ? 8 : 0),
              transform: Matrix4.translationValues(_hovering ? 12 : 0, 0, 0),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
