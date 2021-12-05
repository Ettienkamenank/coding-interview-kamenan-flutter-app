String getInitials(String str) {
  var result = '';
  var v = true;

  for (var i in str.runes) {
    // If it is space, set v as true.
    if (String.fromCharCode(i) == ' ') {
      v = true;
    }

    // Else check if v is true or not.
    // If true, copy character in output
    // string and set v as false.
    else if (String.fromCharCode(i) != ' ' && v) {
      result += (String.fromCharCode(i));
      v = false;
    }
  }

  return result.toUpperCase();
}

String mapPeriodicityToFrench(String str) {
  switch (str) {
    case 'WEEKLY':
      return 'HEBDOMADAIRE';

    case 'MONTHLY':
      return 'MENSUEL';

    case 'ANNUAL':
      return 'ANNUEL';

    default:
      return '';
  }
}
