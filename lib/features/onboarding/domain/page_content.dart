import 'package:equatable/equatable.dart';
import 'package:foode/generated/assets.dart';
class PageContent extends Equatable {
  const PageContent({
    required this.title,
    required this.image,
    required this.description,
  });

  const PageContent.first()
    : this(
        title: 'Brand new curriculum',
        image: Assets.logoLoginLogo,
        description:
            'This is the first online education platform designed by the world\'s top professors.',
      );

  const PageContent.second()
    : this(
        title: 'Brand a fun atmosphere',
        image: Assets.logoLoginLogo,
        description:
            'This is the first online education platform designed by the world\'s top professors.',
      );

  const PageContent.third()
    : this(
        title: 'Easy to join the lesson',
        image: Assets.logoLoginLogo,
        description:
            'This is the first online education platform designed by the world\'s top professors.',
      );
  final String title;
  final String image;
  final String description;

  @override
  List<Object?> get props => [title, image, description];
}
