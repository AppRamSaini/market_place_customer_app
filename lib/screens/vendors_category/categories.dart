import 'package:market_place_customer/data/models/dashbaord_offers_model.dart';

import '../../utils/exports.dart';

class CategoriesList extends StatefulWidget {
  final List<CategoryElement>? popularCategory;
  final String? type;
  final int page;

  Function(String category)? onTap;

  CategoriesList(
      {super.key,
      this.popularCategory,
      this.type,
      required this.page,
      required this.onTap});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          widget.popularCategory!.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              final categoryName = widget.popularCategory?[index].name;
              if (widget.onTap != null && categoryName != null) {
                widget.onTap!(categoryName);
              }

              context.read<FetchVendorsBloc>().add(GetVendorsEvent(
                  context: context,
                  category: widget.popularCategory![index].name.toString(),
                  type: widget.type,
                  page: widget.page));
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: size.width * 0.03,
                  right: index == 7 ? size.width * 0.03 : 0.0),
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04, vertical: size.height * 0.008),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: selectedIndex == index
                      ? AppColors.themeColor
                      : AppColors.theme10),
              child: Text(
                widget.popularCategory![index].name ?? '',
                style: AppStyle.medium_12(selectedIndex == index
                    ? AppColors.white80
                    : AppColors.black20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
