class MyValidator{

  static String? validateName(String? value){
    if(value!.isEmpty){
      return 'Enter name';
    }
    return null;
  }

  static String? validateAge(String? value){
    if(value!.isEmpty){
      return 'Enter age';
    }
    return null;
  }
  static String? validatePhone(String? value){
    if(value!.isEmpty){
      return 'Enter number';
    }
    else if(value.length < 10){
      return '10 digit required';
    }
    return null;
  }

  static String? validateEmail(String? value){
    if(value!.isEmpty){
      return 'Enter email';
    }
    if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }
  static String? validatePassword(String? value ){
    if(value!.isEmpty){
      return 'Enter Password';
    }
    if(value.length <  6){
      return 'password must be 6 digit';
    }
    return null;

  }
}