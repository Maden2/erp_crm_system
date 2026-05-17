class CompanyEntity {
  final String name;
  final String status;
  final String? logoUrl;

  CompanyEntity({
    required this.name,
    required this.status,
    this.logoUrl,
  });
}