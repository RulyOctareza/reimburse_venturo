import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class CurrencyFormatter {
  static String formatToRupiah(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return formatter.format(amount).trim();
  }

  static int parseFromRupiah(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove all non-digit characters
    final numericValue = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericValue.isEmpty) {
      return const TextEditingValue();
    }

    // Parse to int
    final intValue = int.tryParse(numericValue);
    if (intValue == null) {
      return oldValue;
    }

    // Format with dots
    final formatted = CurrencyFormatter.formatToRupiah(intValue);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
