import '../enums/rating_category.dart';

extension RatingCategoryExt on RatingCategory {
  String get valueName => switch (this) {
        RatingCategory.all => 'All',
        RatingCategory.unpopular => 'Not Popular',
        RatingCategory.bad => 'Bad',
        RatingCategory.good => 'Good',
        RatingCategory.great => 'Great',
        RatingCategory.recommended => 'Recommended',
      };
}
