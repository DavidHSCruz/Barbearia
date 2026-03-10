import '../../domain/entities/landing_content.dart';

class ServiceItemModel extends ServiceItem {
  const ServiceItemModel({
    required super.title,
    required super.description,
    required super.iconPath,
  });

  factory ServiceItemModel.empty() {
    return ServiceItemModel(title: '', description: '', iconPath: '');
  }

  factory ServiceItemModel.fromJson(Map<String, dynamic> json) {
    return ServiceItemModel(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      iconPath: json['iconPath'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'description': description, 'iconPath': iconPath};
  }

  factory ServiceItemModel.fromEntity(ServiceItem entity) {
    return ServiceItemModel(
      title: entity.title,
      description: entity.description,
      iconPath: entity.iconPath,
    );
  }
}
