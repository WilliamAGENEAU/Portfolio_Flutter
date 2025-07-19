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
    NavItemData(name: StringConst.ABOUT, route: StringConst.ABOUT_PAGE),
    NavItemData(name: StringConst.WORKS, route: StringConst.WORKS_PAGE),
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
    Projects.CLUB,
  ];

  static List<ProjectItemData> projects = [
    Projects.MUSEUM_EDIBLE_EARTH,
    Projects.CONNECTED_CHESSBOARD,
    Projects.MOTION_DESIGN,
    Projects.CLUB,
  ];

  static List<NoteWorthyProjectDetails> noteworthyProjects = [
    NoteWorthyProjectDetails(
      projectName: StringConst.UDAGRAM_IMAGE_FILTERING,
      isPublic: true,
      isOnPlayStore: false,
      isWeb: false,
      technologyUsed: StringConst.UDAGRAM_IMAGE_FILTERING_TECH,
      projectDescription: StringConst.UDAGRAM_IMAGE_FILTERING_DETAIL,
      gitHubUrl: StringConst.UDAGRAM_IMAGE_FILTERING_GITHUB_URL,
      isLive: false,
    ),
    NoteWorthyProjectDetails(
      projectName: StringConst.SERVERLESS_TODO,
      isPublic: true,
      isOnPlayStore: false,
      isWeb: false,
      technologyUsed: StringConst.SERVERLESS_TODO_TECH,
      projectDescription: StringConst.SERVERLESS_TODO_DETAIL,
      gitHubUrl: StringConst.SERVERLESS_TODO_GITHUB_URL,
      isLive: false,
    ),
    NoteWorthyProjectDetails(
      projectName: StringConst.PYTHON_ALGORITHMS,
      isPublic: true,
      isOnPlayStore: false,
      isWeb: false,
      technologyUsed: StringConst.PYTHON,
      projectDescription: StringConst.PYTHON_ALGORITHMS_DETAIL,
      gitHubUrl: StringConst.PYTHON_ALGORITHMS_GITHUB_URL,
      isLive: false,
    ),
    NoteWorthyProjectDetails(
      projectName: StringConst.PROGRAMMING_FOR_DATA_SCIENCE,
      isPublic: true,
      isOnPlayStore: false,
      isWeb: false,
      technologyUsed: StringConst.PYTHON,
      projectDescription: StringConst.PROGRAMMING_FOR_DATA_SCIENCE_DETAIL,
      gitHubUrl: StringConst.PROGRAMMING_FOR_DATA_SCIENCE_GITHUB_URL,
      isLive: false,
    ),
    NoteWorthyProjectDetails(
      projectName: StringConst.ONBOARDING_APP,
      isPublic: true,
      isOnPlayStore: false,
      isWeb: false,
      technologyUsed: StringConst.FLUTTER,
      projectDescription: StringConst.ONBOARDING_APP_DETAIL,
      gitHubUrl: StringConst.ONBOARDING_APP_GITHUB_URL,
      isLive: false,
    ),
    NoteWorthyProjectDetails(
      projectName: StringConst.FINOPP,
      isPublic: true,
      isOnPlayStore: false,
      isWeb: false,
      technologyUsed: StringConst.FLUTTER,
      projectDescription: StringConst.FINOPP_DETAIL,
      gitHubUrl: StringConst.FINOPP_GITHUB_URL,
      isLive: false,
    ),
    NoteWorthyProjectDetails(
      projectName: StringConst.AMOR_APP,
      isPublic: true,
      isOnPlayStore: false,
      isWeb: true,
      technologyUsed: StringConst.FLUTTER,
      projectDescription: StringConst.AMOR_APP_DETAIL,
      gitHubUrl: StringConst.AMOR_APP_GITHUB_URL,
      webUrl: StringConst.AMOR_APP_WEB_URL,
      isLive: true,
    ),
  ];

  static List<CertificationData> certificationData = [
    CertificationData(
      title: StringConst.MSC_IT,
      url: StringConst.CMU_CERT_URL,
      image: ImagePath.CMU_MASTERS_CERT,
      imageSize: 0.325,
      awardedBy: StringConst.CMU,
    ),
    CertificationData(
      title: StringConst.ASSOCIATE_ANDROID_DEV,
      url: StringConst.ASSOCIATE_ANDROID_DEV_URL,
      image: ImagePath.ASSOCIATE_ANDROID_DEV,
      imageSize: 0.325,
      awardedBy: StringConst.GOOGLE,
    ),
    CertificationData(
      title: StringConst.CLOUD_DEVELOPER,
      url: StringConst.CLOUD_DEVELOPER_URL,
      image: ImagePath.CLOUD_DEVELOPER_CERT,
      imageSize: 0.325,
      awardedBy: StringConst.UDACITY,
    ),
    CertificationData(
      title: StringConst.DATA_SCIENCE,
      url: StringConst.DATA_SCIENCE_CERT_URL,
      image: ImagePath.DATA_SCIENCE_CERT,
      imageSize: 0.325,
      awardedBy: StringConst.UDACITY,
    ),
    CertificationData(
      title: StringConst.ANDROID_BASICS,
      url: StringConst.ANDROID_BASICS_CERT_URL,
      image: ImagePath.ANDROID_BASICS_CERT,
      imageSize: 0.325,
      awardedBy: StringConst.UDACITY,
    ),
  ];

  static List<ExperienceData> experienceData = [
    ExperienceData(
      company: StringConst.COMPANY_5,
      position: StringConst.POSITION_5,
      companyUrl: StringConst.COMPANY_5_URL,
      roles: [
        StringConst.COMPANY_5_ROLE_1,
        StringConst.COMPANY_5_ROLE_2,
        StringConst.COMPANY_5_ROLE_3,
      ],
      location: StringConst.LOCATION_5,
      duration: StringConst.DURATION_5,
    ),
    ExperienceData(
      company: StringConst.COMPANY_4,
      position: StringConst.POSITION_4,
      companyUrl: StringConst.COMPANY_4_URL,
      roles: [
        StringConst.COMPANY_4_ROLE_1,
        StringConst.COMPANY_4_ROLE_2,
        StringConst.COMPANY_4_ROLE_3,
      ],
      location: StringConst.LOCATION_4,
      duration: StringConst.DURATION_4,
    ),
    ExperienceData(
      company: StringConst.COMPANY_3,
      position: StringConst.POSITION_3,
      companyUrl: StringConst.COMPANY_3_URL,
      roles: [
        StringConst.COMPANY_3_ROLE_1,
        StringConst.COMPANY_3_ROLE_2,
        StringConst.COMPANY_3_ROLE_3,
      ],
      location: StringConst.LOCATION_3,
      duration: StringConst.DURATION_3,
    ),
    ExperienceData(
      company: StringConst.COMPANY_2,
      position: StringConst.POSITION_2,
      companyUrl: StringConst.COMPANY_2_URL,
      roles: [
        StringConst.COMPANY_2_ROLE_1,
        StringConst.COMPANY_2_ROLE_2,
        StringConst.COMPANY_2_ROLE_3,
      ],
      location: StringConst.LOCATION_2,
      duration: StringConst.DURATION_2,
    ),
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

  static ProjectItemData CLUB = ProjectItemData(
    title: StringConst.CLUB,
    subtitle: StringConst.CLUB,
    primaryColor: AppColors.club,
    category: StringConst.CLUB_CATEGORY,
    designer: StringConst.CLUB_DESIGNER,
    platform: StringConst.CLUB_PLATFORM,
    image: ImagePath.CLUB_COVER,
    coverUrl: ImagePath.CLUB_BKG,
    navTitleColor: AppColors.primaryColor,
    navSelectedTitleColor: AppColors.primaryColor,
    appLogoColor: AppColors.primaryColor,
    projectAssets: [
      ImagePath.CLUB_BKG,
      ImagePath.CLUB_1,
      ImagePath.CLUB_2,
      ImagePath.CLUB_3,
      ImagePath.CLUB_4,
    ],
    portfolioDescription: StringConst.CLUB_DETAIL,
    isPublic: false,
    isOnPlayStore: false,
    technologyUsed: StringConst.WORDPRESS,
    gitHubUrl: StringConst.CLUB_GITHUB_URL,
    playStoreUrl: StringConst.CLUB_PLAYSTORE_URL,
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

  static ProjectItemData AERIUM = ProjectItemData(
    title: StringConst.AERIUM,
    subtitle: StringConst.AERIUM_SUBTITLE,
    primaryColor: AppColors.aerium_v1,
    platform: StringConst.AERIUM_PLATFORM,
    category: StringConst.AERIUM_CATEGORY,
    designer: StringConst.AERIUM_DESIGNER,
    image: ImagePath.AERIUM_COVER,
    coverUrl: ImagePath.AERIUM_COVER,
    navTitleColor: AppColors.aeriumV1NavTitle,
    projectAssets: [
      ImagePath.AERIUM_COVER,
      ImagePath.AERIUM_DESIGN_2,
      ImagePath.AERIUM_DESIGN_3,
    ],
    portfolioDescription: StringConst.AERIUM_DETAIL,
    isPublic: true,
    isLive: true,
    technologyUsed: StringConst.FLUTTER,
    gitHubUrl: StringConst.AERIUM_GITHUB_URL,
    webUrl: StringConst.AERIUM_WEB_URL,
  );
  static ProjectItemData AERIUM_V2 = ProjectItemData(
    title: StringConst.AERIUM_V2,
    subtitle: StringConst.AERIUM_V2_SUBTITLE,
    category: StringConst.AERIUM_V2_CATEGORY,
    designer: StringConst.AERIUM_V2_DESIGNER,
    primaryColor: AppColors.aerium_v1,
    platform: StringConst.AERIUM_V2_PLATFORM,
    image: ImagePath.AERIUM_V2_LAST,
    coverUrl: ImagePath.AERIUM_V2_LAST,
    portfolioDescription: StringConst.AERIUM_V2_DETAIL,
    projectAssets: [
      ImagePath.AERIUM_V2_OVERALL,
      ImagePath.AERIUM_V2_FIRST,
      ImagePath.AERIUM_V2_TYPOGRAPHY,
      ImagePath.AERIUM_V2_LAST,
    ],
    isPublic: true,
    isLive: true,
    technologyUsed: StringConst.FLUTTER,
    gitHubUrl: StringConst.AERIUM_V2_GITHUB_URL,
    webUrl: StringConst.AERIUM_V2_WEB_URL,
  );
}
