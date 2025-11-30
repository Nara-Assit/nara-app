import 'package:nara/core/helpers/app_assets.dart';

class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
  static List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      imagePath: AppAssets.imagesOnboarding1,
      title: "تواصل بلا حدود",
      description:
          "حوّل كلامك إلى صوت أو أصوات الآخرين إلى\n نص بسهولة وبدون إحراج",
    ),
    OnboardingModel(
      imagePath: AppAssets.imagesOnboarding2,
      title: "تواصل بسهولة",
      description: "أرسل واستقبل الرسائل النصية والصوتية بدون\n أي قيود",
    ),
    OnboardingModel(
      imagePath: AppAssets.imagesOnboarding3,
      title: "ابقَ متصلًا بأمان",
      description:
          'استخدم الكاميرا والمايك للتواصل، وفعل حالة\n الطوارئ عند الحاجة بسرعة وسهولة',
    ),
    OnboardingModel(
      imagePath: AppAssets.imagesOnboarding4,
      title: "تعلّم بسهولة",
      description:
          'دورات وتدريبات تفاعلية تساعدك على تعلم لغة \nالاشارة والتواصل بثقة',
    ),
    OnboardingModel(
      imagePath: AppAssets.imagesOnboarding5,
      title: "احجز بسهولة",
      description: 'جدول مواعيدك ومحادثاتك مع الآخرين بكل\n سهولة ودون عناء.',
    ),
  ];
}
