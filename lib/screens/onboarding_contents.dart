class OnboardingContents {
  final String title;
  final String image;

  OnboardingContents({
    required this.title,
    required this.image,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Uh-oh! You have exceeded your recommended time!",
    image: "assets/images/red-traffic-light.png",
  ),
  OnboardingContents(
    title: "Warning! You are about to exceed your recommended time!",
    image: "assets/images/yellow-traffic-light.png",
  ),
  OnboardingContents(
    title: "Wow! You are below your recommended time!",
    image: "assets/images/green-traffic-light.png",

  ),
];
