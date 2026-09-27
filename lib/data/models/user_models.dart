class UserProfile {
  const UserProfile({required this.nameKey, required this.rating, required this.trips});

  final String nameKey;
  final double rating;
  final int trips;
}

class OnboardingSlide {
  const OnboardingSlide({
    required this.titleKey,
    required this.bodyKey,
    required this.image,
  });

  final String titleKey;
  final String bodyKey;
  final String image;
}
