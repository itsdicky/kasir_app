class StringUtils {
  static String priceFormatter(int price) {
    return 'Rp.${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';
  }
}
