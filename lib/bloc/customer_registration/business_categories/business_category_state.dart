part of 'business_category_cubit.dart';

@immutable
sealed class BusinessCategoryState {}
final class BusinessCategoryInitial extends BusinessCategoryState {}
final class BusinessCategoryLoading extends BusinessCategoryState {}
final class BusinessCategoryLoaded extends BusinessCategoryState {
  final MerchantCategoryModel categoryData;
  BusinessCategoryLoaded({required this.categoryData});
}
final class BusinessCategoryFailed extends BusinessCategoryState {}
final class BusinessCategoryInternetError extends BusinessCategoryState {}



