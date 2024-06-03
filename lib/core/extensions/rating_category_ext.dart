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

  (num?, num?) getRange() => switch (this) {
        RatingCategory.all => (null, null),
        RatingCategory.unpopular => (0, 2),
        RatingCategory.bad => (2.1, 4),
        RatingCategory.good => (4.1, 6),
        RatingCategory.great => (6.1, 8),
        RatingCategory.recommended => (8.1, 10),
      };
}
