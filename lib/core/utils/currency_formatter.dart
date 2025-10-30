import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Utility class for currency formatting (Rupiah)
class CurrencyFormatter {
  /// Format an integer amount to Rupiah string (e.g., 20000 -> 20.000)
  static String formatToRupiah(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return formatter.format(amount).trim();
  }

  /// Parse Rupiah string to integer (e.g., "20.000" -> 20000)
  static int parseFromRupiah(String text) {
    final cleaned = text.replaceAll(RegExp(r'[^0-9]'), '');
    return int.tryParse(cleaned) ?? 0;
  }
}

/// TextInputFormatter for currency input with dots every 3 digits
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
