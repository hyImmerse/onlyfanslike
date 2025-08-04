class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    
    if (!emailRegex.hasMatch(value)) {
      return '올바른 이메일 형식이 아닙니다';
    }
    
    return null;
  }
  
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요';
    }
    
    if (value.length < 8) {
      return '비밀번호는 최소 8자 이상이어야 합니다';
    }
    
    return null;
  }
  
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? '이 항목'}을(를) 입력해주세요';
    }
    return null;
  }
  
  static String? minLength(String? value, int minLength, {String? fieldName}) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? '이 항목'}을(를) 입력해주세요';
    }
    
    if (value.length < minLength) {
      return '${fieldName ?? '이 항목'}은(는) 최소 $minLength자 이상이어야 합니다';
    }
    
    return null;
  }
  
  static String? price(String? value) {
    if (value == null || value.isEmpty) {
      return '가격을 입력해주세요';
    }
    
    final price = int.tryParse(value.replaceAll(',', ''));
    if (price == null || price < 0) {
      return '올바른 가격을 입력해주세요';
    }
    
    return null;
  }
}