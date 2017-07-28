$(function(){



$('#tagInput').selectize({
  delimeter: ',',
  persist: false,
  create: function (input) {
    return {
      value: input,
      text: input
    }
  }
});

})
