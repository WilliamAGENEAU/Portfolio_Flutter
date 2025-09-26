// ignore_for_file: non_constant_identifier_names

part of 'values.dart';

class CertificationData {
  CertificationData({
    required this.title,
    required this.image,
    required this.imageSize,
    required this.url,
    required this.awardedBy,
  });

  final String image;
  final double imageSize;
  final String url;
  final String title;
  final String awardedBy;
}

class NoteWorthyProjectDetails {
  NoteWorthyProjectDetails({
    required this.projectName,
    required this.isOnPlayStore,
    required this.isPublic,
    required this.technologyUsed,
    required this.isWeb,
    required this.isLive,
    this.projectDescription,
    this.playStoreUrl,
    this.webUrl,
    this.hasBeenReleased,
    this.gitHubUrl,
  });

  final String projectName;
  final bool isPublic;
  final bool isOnPlayStore;
  final bool isWeb;
  final String? projectDescription;
  final bool isLive;
  final bool? hasBeenReleased;
  final String? playStoreUrl;
  final String? gitHubUrl;
  final String? webUrl;
  final String? technologyUsed;
}

class ExperienceData {
  ExperienceData({
    required this.position,
    required this.roles,
    required this.location,
    required this.duration,
    required this.company,
    this.companyUrl,
  });

  final String company;
  final String? companyUrl;
  final String location;
  final String duration;
  final String position;
  final List<String> roles;
}

class SkillData {
  SkillData({required this.skillName, required this.skillLevel});

  final String skillName;
  final double skillLevel;
}

class SubMenuData {
  SubMenuData({
    required this.title,
    this.isSelected,
    this.content,
    this.skillData,
    this.isAnimation = false,
  });

  final String title;
  final String? content;
  final List<SkillData>? skillData;
  bool isAnimation;
  bool? isSelected;
}

class Data {
  static List<NavItemData> menuItems = [
    NavItemData(name: StringConst.HOME, route: StringConst.HOME_PAGE),
    NavItemData(name: StringConst.PROJETS, route: StringConst.WORKS_PAGE),
    NavItemData(name: StringConst.CONTACT, route: StringConst.CONTACT_PAGE),
  ];

  static List<SocialData> socialData = [
    SocialData(
      name: StringConst.GITHUB,
      iconData: FontAwesomeIcons.github,
      url: StringConst.GITHUB_URL,
    ),
    SocialData(
      name: StringConst.LINKED_IN,
      iconData: FontAwesomeIcons.linkedin,
      url: StringConst.LINKED_IN_URL,
    ),

    SocialData(
      name: StringConst.INSTAGRAM,
      iconData: FontAwesomeIcons.instagram,
      url: StringConst.INSTAGRAM_URL,
    ),
  ];

  static List<String> ui = [
    "Figma",
    "UX Research",
    "Chakra UI",
    "Wireframing",
    "Blender",
    "Resolume",
  ];

  static List<String> otherTechnologies = [
    "Flutter",
    "HTML 5",
    "CSS 3",
    "Python",
    "JavaScript",
    "React JS",
    "Node JS",
    "Git",
    "Google Cloud",
    "Azure",
    "PHP",
    "SQL",
    "Embedded C/C++",
    "Firebase",
    "Wordpress",
    "Machine Learning",
    "Development .NET",
    "Edge computing",
    "Bluetooth",
    "Zigbee",
    "LoRa",
  ];
  static List<SocialData> socialData1 = [
    SocialData(
      name: StringConst.GITHUB,
      iconData: FontAwesomeIcons.github,
      url: StringConst.GITHUB_URL,
    ),
    SocialData(
      name: StringConst.LINKED_IN,
      iconData: FontAwesomeIcons.linkedin,
      url: StringConst.LINKED_IN_URL,
    ),
  ];

  static List<SocialData> socialData2 = [
    SocialData(
      name: StringConst.LINKED_IN,
      iconData: FontAwesomeIcons.linkedin,
      url: StringConst.LINKED_IN_URL,
    ),

    SocialData(
      name: StringConst.INSTAGRAM,
      iconData: FontAwesomeIcons.instagram,
      url: StringConst.INSTAGRAM_URL,
    ),
  ];

  static List<ProjectItemData> recentWorks = [
    Projects.MUSEUM_EDIBLE_EARTH,
    Projects.CONNECTED_CHESSBOARD,
    Projects.MOTION_DESIGN,
    Projects.MARVEL,
    Projects.ELEVAGEY,
  ];

  static List<ProjectItemData> projects = [
    Projects.MUSEUM_EDIBLE_EARTH,
    Projects.CONNECTED_CHESSBOARD,
    Projects.MOTION_DESIGN,
    Projects.MARVEL,
    Projects.ELEVAGEY,
    Projects.INAZUMA,
  ];
}

class Projects {
  static ProjectItemData MUSEUM_EDIBLE_EARTH = ProjectItemData(
    title: StringConst.MUSEUM_OF_EDIBLE_EARTH,
    subtitle: StringConst.MUSEUM_OF_EDIBLE_EARTH,
    platform: StringConst.MUSEUM_PLATFORM,
    primaryColor: AppColors.primaryColor,
    image: ImagePath.MUSEUM_COVER,
    coverUrl: ImagePath.MUSEUM_SCREENS,
    navSelectedTitleColor: AppColors.primaryColor,
    appLogoColor: AppColors.primaryColor,
    projectAssets: [
      ImagePath.MUSEUM_1,
      ImagePath.MUSEUM_2,
      ImagePath.MUSEUM_3,
      ImagePath.MUSEUM_4,
    ],
    category: StringConst.MUSEUM_PLUS_CATEGORY,
    portfolioDescription: StringConst.MUSEUM_DETAIL,
    isPublic: false,
    isOnPlayStore: false,
    technologyUsed: StringConst.WORDPRESS,
    gitHubUrl: StringConst.MUSEUM_GITHUB_URL,
    playStoreUrl: StringConst.MUSEUM_PLAYSTORE_URL,
  );
  static ProjectItemData CONNECTED_CHESSBOARD = ProjectItemData(
    title: StringConst.CONNECTED_CHESSBOARD,
    subtitle: StringConst.CONNECTED_CHESSBOARD,
    platform: StringConst.CHESS_PLATFORM,
    primaryColor: AppColors.chessboard,
    image: ImagePath.CHESSBOARD_COVER,
    coverUrl: ImagePath.CHESSBOARD_COVER,
    navSelectedTitleColor: AppColors.primaryColor,
    appLogoColor: AppColors.primaryColor,
    projectAssets: [
      ImagePath.CHESS_SCREENS,
      ImagePath.CHESS_1,
      ImagePath.CHESS_2,
      ImagePath.CHESS_3,
      ImagePath.CHESS_4,
      ImagePath.CHESS_5,
      ImagePath.CHESS_6,
    ],
    category: StringConst.CHESSBOARD_IOT_CATEGORY,
    portfolioDescription: StringConst.CHESS_DETAIL,
    isPublic: true,
    isOnPlayStore: false,
    technologyUsed: StringConst.PYTHON,
    gitHubUrl: StringConst.CHESS_GITHUB_URL,
    playStoreUrl: StringConst.CHESS_PLAYSTORE_URL,
  );

  static ProjectItemData MARVEL = ProjectItemData(
    title: StringConst.MARVEL,
    subtitle: StringConst.MARVEL,
    primaryColor: AppColors.marvel,
    category: StringConst.MARVEL_CATEGORY,
    designer: StringConst.MARVEL_DESIGNER,
    platform: StringConst.MARVEL_PLATFORM,
    image: ImagePath.MARVEL_COVER,
    coverUrl: ImagePath.MARVEL_BKG,
    navTitleColor: AppColors.primaryColor,
    navSelectedTitleColor: AppColors.primaryColor,
    appLogoColor: AppColors.primaryColor,
    projectAssets: [
      ImagePath.MARVEL_BKG,
      ImagePath.MARVEL_COVER,
      ImagePath.MARVEL_1,
      ImagePath.MARVEL_2,
      ImagePath.MARVEL_3,
    ],
    portfolioDescription: StringConst.MARVEL_DETAIL,
    isPublic: true,
    isOnPlayStore: false,
    technologyUsed: StringConst.FLUTTER,
    gitHubUrl: StringConst.MARVEL_GITHUB_URL,
    playStoreUrl: StringConst.MARVEL_PLAYSTORE_URL,
  );
  static ProjectItemData ELEVAGEY = ProjectItemData(
    title: StringConst.ELEVAGEY,
    subtitle: StringConst.ELEVAGEY,
    primaryColor: AppColors.elevagey,
    category: StringConst.ELEVAGEY_CATEGORY,
    designer: StringConst.ELEVAGEY_DESIGNER,
    platform: StringConst.ELEVAGEY_PLATFORM,
    image: ImagePath.ELEVAGEY_COVER,
    coverUrl: ImagePath.ELEVAGEY_COVER,
    navTitleColor: AppColors.primaryColor,
    navSelectedTitleColor: AppColors.primaryColor,
    appLogoColor: AppColors.primaryColor,
    projectAssets: [
      ImagePath.ELEVAGEY_COVER,
      ImagePath.ELEVAGEY_1,
      ImagePath.ELEVAGEY_2,
    ],
    portfolioDescription: StringConst.MARVEL_DETAIL,
    isPublic: true,
    isOnPlayStore: false,
    technologyUsed: StringConst.FLUTTER,
    gitHubUrl: StringConst.MARVEL_GITHUB_URL,
    playStoreUrl: StringConst.MARVEL_PLAYSTORE_URL,
  );
  static ProjectItemData MOTION_DESIGN = ProjectItemData(
    title: StringConst.MOTION_DESIGN,
    primaryColor: AppColors.motion_design,
    subtitle: StringConst.MOTION_DESIGN,
    category: StringConst.MOTION_CATEGORY,
    platform: StringConst.MOTION_PLATFORM,
    image: ImagePath.MOTION_COVER,
    coverUrl: ImagePath.MOTION_COVER,
    portfolioDescription: StringConst.MOTION_DETAIL,
    navTitleColor: AppColors.primaryColor,
    navSelectedTitleColor: AppColors.primaryColor,
    appLogoColor: AppColors.primaryColor,
    projectAssets: [
      ImagePath.MOTION_1,
      ImagePath.MOTION_2,
      ImagePath.MOTION_3,
      ImagePath.MOTION_4,
      ImagePath.MOTION_5,
      ImagePath.MOTION_6,
      ImagePath.MOTION_7,
    ],
    isPublic: false,
    isOnPlayStore: false,
    technologyUsed: StringConst.BLENDER,
    gitHubUrl: StringConst.MOTION_GITHUB_URL,
    playStoreUrl: StringConst.MOTION_PLAYSTORE_URL,
  );
  static ProjectItemData INAZUMA = ProjectItemData(
    title: StringConst.INAZUMA,
    subtitle: StringConst.INAZUMA,
    primaryColor: AppColors.inazuma,
    category: StringConst.INAZUMA_CATEGORY,
    designer: StringConst.INAZUMA_DESIGNER,
    platform: StringConst.INAZUMA_PLATFORM,
    image: ImagePath.INAZUMA_COVER,
    coverUrl: ImagePath.INAZUMA_COVER,
    navTitleColor: AppColors.primaryColor,
    navSelectedTitleColor: AppColors.primaryColor,
    appLogoColor: AppColors.primaryColor,
    projectAssets: [ImagePath.INAZUMA_COVER],
    portfolioDescription: StringConst.MARVEL_DETAIL,
    isPublic: true,
    isOnPlayStore: false,
    technologyUsed: StringConst.FLUTTER,
    gitHubUrl: StringConst.MARVEL_GITHUB_URL,
    playStoreUrl: StringConst.MARVEL_PLAYSTORE_URL,
  );
}
