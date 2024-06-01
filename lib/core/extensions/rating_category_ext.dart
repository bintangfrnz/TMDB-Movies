import '../enums/rating_category.dart';

extension RatingCategoryExt on RatingCategory {
  String get valueName => switch (this) {
        RatingCategory.all => 'All',
        RatingCategory.bad => 'Bad',
        RatingCategory.good => 'Good',
        RatingCategory.great => 'Great',
        RatingCategory.recommended => 'Recommended',
      };
}
