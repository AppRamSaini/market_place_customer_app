
import '../../../utils/exports.dart';
part 'business_category_state.dart';

class BusinessCategoryCubit extends Cubit<BusinessCategoryState> {
  BusinessCategoryCubit() : super(BusinessCategoryInitial());

  AuthRepository repository = AuthRepository();

  fetchBusinessCategory() async {
    emit(BusinessCategoryLoading());
    try {
  //     var categoryData = await repository.fetchMerchantCategory();
  //
  //     if (categoryData != null) {
  //       emit(BusinessCategoryLoaded(categoryData: categoryData));
  //     } else {
  //       emit(BusinessCategoryFailed());
  //     }
  //   } on SocketException {
  //     emit(BusinessCategoryInternetError());
    } catch (e) {
      print(e);
      emit(BusinessCategoryFailed());
    }
  }
}


