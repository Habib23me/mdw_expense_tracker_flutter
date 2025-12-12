import 'package:json_annotation/json_annotation.dart';

enum Category {
  @JsonValue('Food')
  food,
  @JsonValue('Transport')
  transport,
  @JsonValue('Entertainment')
  entertainment,
  @JsonValue('Other')
  other;

  /// Returns the display name for the .
  String get displayName {
    switch (this) {
      case .food:
        return 'Food';
      case .transport:
        return 'Transport';
      case .entertainment:
        return 'Entertainment';
      case .other:
        return 'Other';
    }
  }

  /// Creates a Category from a string value (for JSON parsing).
  static Category? fromString(String value) {
    switch (value) {
      case 'Food':
        return .food;
      case 'Transport':
        return .transport;
      case 'Entertainment':
        return .entertainment;
      case 'Other':
        return .other;
      default:
        return null;
    }
  }
}

class CategoryJsonConverter implements JsonConverter<Category, String> {
  const CategoryJsonConverter();

  @override
  Category fromJson(String json) {
    return .fromString(json) ?? .other;
  }

  @override
  String toJson(Category object) => object.displayName;
}
