class Validators {
  static String? emptyField(dynamic value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez remplir ce champ';
    } else {
      return null;
    }
  }

  static String? correctPassword(dynamic value) {
    var emptyResult = emptyField(value);
    if (emptyResult == null || emptyResult.isEmpty) {
      var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&*-]).{8,}$';
      var regExp = RegExp(pattern);
      if (!regExp.hasMatch(value)) {
        return 'Votre mot de passe doit comporter au moins 8 caractères comprenant des chiffres, des lettres majuscules et minuscules et des caractères spéciaux (!@#\$%^&*).';
      } else {
        return null;
      }
    } else {
      return emptyResult;
    }
  }

  static String? confirmPassword(dynamic value) {
    if (value[0] == value[1]) {
      return null;
    } else {
      return 'Entrez le meme mot de passe';
    }
  }

  static String? validateEmail(dynamic value) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regExp = RegExp(pattern);
    var emptyResult = emptyField(value);
    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return 'Adresse email invalide';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(dynamic value) {
    var pattern = r'^[0-9]{10}$';
    var regExp = RegExp(pattern);
    var emptyResult = emptyField(value);

    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return 'Veuillez entrer un numéro de téléphone à 10 chiffres';
    } else {
      return null;
    }
  }

  static String? validatePin(dynamic value) {
    var pattern = r'^[0-9]{4,}$';
    var regExp = RegExp(pattern);
    var emptyResult = emptyField(value);

    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return "Veuillez entrer un code pin d'au moins 4 chiffres";
    } else {
      return null;
    }
  }

  static String? validateName(dynamic value) {
    var pattern = r'^.{2,20}$';
    var regExp = RegExp(pattern);
    var emptyResult = emptyField(value);

    if (emptyResult != null) {
      return emptyResult;
    } else if (!regExp.hasMatch(value)) {
      return "Veuillez entrer un nom ou prénom d'au moins 2 lettres";
    } else {
      return null;
    }
  }

//End
}
