function translateValidationMessages(currentLang) {

  message = {
    en: {
      required: "Required.",
      remote: "Please fix this field.",
      email: "Wrong email.",
      url: "Please enter a valid URL.",
      date: "Please enter a valid date.",
      dateISO: "Please enter a valid date (ISO).",
      number: "Please enter a valid number.",
      digits: "Please enter only digits.",
      creditcard: "Please enter a valid credit card number.",
      equalTo: "Please enter the same value again.",
      maxlength: $.validator.format("Please enter no more than {0} characters."),
      minlength: $.validator.format("Please enter at least {0} characters."),
      rangelength: $.validator.format("Please enter a value between {0} and {1} characters long."),
      range: $.validator.format("Please enter a value between {0} and {1}."),
      max: $.validator.format("Please enter a value less than or equal to {0}."),
      min: $.validator.format("Please enter a value greater than or equal to {0}.")
    },
    km: {
      required: "See vÃ¤li peab olema tÃ¤idetud.",
      maxlength: $.validator.format("Palun sisestage vÃ¤hem kui {0} tÃ¤hemÃ¤rki."),
      minlength: $.validator.format("Palun sisestage vÃ¤hemalt {0} tÃ¤hemÃ¤rki."),
      rangelength: $.validator.format("Palun sisestage vÃ¤Ã¤rtus vahemikus {0} kuni {1} tÃ¤hemÃ¤rki."),
      email: "Palun sisestage korrektne e-maili aadress.",
      url: "Palun sisestage korrektne URL.",
      date: "Palun sisestage korrektne kuupÃ¤ev.",
      dateISO: "Palun sisestage korrektne kuupÃ¤ev (YYYY-MM-DD).",
      number: "Palun sisestage korrektne number.",
      digits: "Palun sisestage ainult numbreid.",
      equalTo: "Palun sisestage sama vÃ¤Ã¤rtus uuesti.",
      range: $.validator.format("Palun sisestage vÃ¤Ã¤rtus vahemikus {0} kuni {1}."),
      max: $.validator.format("Palun sisestage vÃ¤Ã¤rtus, mis on vÃ¤iksem vÃµi vÃµrdne arvuga {0}."),
      min: $.validator.format("Palun sisestage vÃ¤Ã¤rtus, mis on suurem vÃµi vÃµrdne arvuga {0}."),
      creditcard: "Palun sisestage korrektne krediitkaardi number."
    }
  };
//   / alert("Translating validation messages to: "+currentLang);


 if (currentLang == "km") {
    $.extend($.validator.messages, message.km);
  } else {
    $.extend($.validator.messages, message.en);
  }
}