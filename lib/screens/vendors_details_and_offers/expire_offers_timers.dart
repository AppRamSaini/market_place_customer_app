import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_place_customer/utils/app_colors.dart';
import 'package:market_place_customer/utils/app_styles.dart';

class OfferExpiryTimer extends StatefulWidget {
  DateTime expiryDate;
  bool isHistoryPage;

  OfferExpiryTimer(
      {super.key, required this.expiryDate, this.isHistoryPage = false});

  @override
  State<OfferExpiryTimer> createState() => _OfferExpiryTimerState();
}

class _OfferExpiryTimerState extends State<OfferExpiryTimer> {
  late Timer _timer;
  Duration _remaining = Duration.zero;
  late DateTime _expiryEndOfDay;

  @override
  void initState() {
    super.initState();
    _setEndOfDayExpiry();
    _updateRemaining();
    _startTimer();
  }

  void _setEndOfDayExpiry() {
    // Offer expires at 11:59:59 PM of its expiry date
    _expiryEndOfDay = DateTime(
      widget.expiryDate.year,
      widget.expiryDate.month,
      widget.expiryDate.day,
      23,
      59,
      59,
    );
  }

  void _updateRemaining() {
    final now = DateTime.now();
    setState(() {
      _remaining = _expiryEndOfDay.difference(now);
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) _updateRemaining();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  bool _isSameDay(DateTime d1, DateTime d2) =>
      d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final isExpired = _remaining.isNegative;
    final isToday = _isSameDay(widget.expiryDate, now);

    String text;
    Color color;

    if (isExpired) {
      text = "Expired";
      color = Colors.redAccent;
    } else if (isToday) {
      // Offer expires tonight at 11:59 PM
      text = "Expires in ${_formatDuration(_remaining)}";
      color = Colors.orangeAccent;
    } else {
      // Future date – static date display
      final formatted = DateFormat('dd MMM yyyy').format(widget.expiryDate);
      text = formatted;
      color = !widget.isHistoryPage ? AppColors.themeColor : AppColors.orange2;
    }

    return Text(text, style: AppStyle.medium_14(color));
  }
}
