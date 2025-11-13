import 'package:market_place_customer/bloc/order_history_bloc/order_history/order_history_bloc.dart';
import 'package:market_place_customer/bloc/order_history_bloc/order_history/order_history_event.dart';
import 'package:market_place_customer/bloc/order_history_bloc/order_history/order_history_state.dart';
import 'package:market_place_customer/bloc/order_history_bloc/save_bill_bloc/upload_gallery_bloc.dart';
import 'package:market_place_customer/bloc/order_history_bloc/save_bill_bloc/upload_gallery_state.dart';
import 'package:market_place_customer/data/models/order_history_%20model.dart';
import 'package:market_place_customer/screens/order_history/order_history_helper_widget.dart';

import '../../utils/exports.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchData({bool isLoadMore = false}) async {
    context.read<OrderHistoryBloc>().add(GetOrderHistoryEvent(
        context: context, page: _page, isLoadMore: isLoadMore));
  }

  void _onScroll() {
    final bloc = context.read<OrderHistoryBloc>();
    final state = bloc.state;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (state is OrderHistorySuccess &&
          !state.hasReachedMax &&
          !state.isPaginating) {
        _page++;
        _fetchData(isLoadMore: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SaveBillBloc, SaveBillState>(listener: (context, state) {
          EasyLoading.dismiss();
          if (state is SaveBillLoading) {
            EasyLoading.show();
          } else if (state is SaveBillFailure) {
            final errorMsg = state.error.toString();
            snackBar(context, errorMsg.toString(), AppColors.redColor);

            print(errorMsg);
            EasyLoading.dismiss();
          } else if (state is SaveBillSuccess) {
            final message = state.saveBillModel.message;

            snackBar(context, message.toString());
            _page = 1;
            _fetchData();
            EasyLoading.dismiss();
          }
        }),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: customAppbar(title: "Order History", context: context),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading && _page == 1) {
              return const BurgerKingShimmer();
            } else if (state is OrderHistoryFailure) {
              return Center(child: Text(state.error));
            } else if (state is OrderHistorySuccess) {
              final List<RedeemedOffer> orders =
                  state.model.data?.redeemedOffers ?? [];

              if (orders.isEmpty) {
                return RefreshIndicator(
                  onRefresh: _fetchData,
                  child: ListView(
                    children: const [
                      SizedBox(height: 200),
                      Center(child: Text("No orders found.")),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: _fetchData,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: orders.length + (state.isPaginating ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == orders.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: AppColors.themeColor,
                          ),
                        ),
                      );
                    }

                    return OrderHistoryCard(
                      orderData: orders[index],
                      index: index,
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
