$(function () {
  var actionContainer = $(".actionmenu");

  window.onload = function () {
    //actionContainer.fadeOut();
    for (var i = 1; i < 10; i++) {
      var data = {
        "vendedor": "Dias Blackwell Tempest",
        "nome": "Maze Bank",
        "imagen": "https://pbs.twimg.com/profile_images/891404814818652160/bm4rOKWS_400x400.jpg",
        "valor": "10000",
        "qtd": "5000",
        "id": i
      }
      AddRowToTable(data);
    }
  };

  window.addEventListener('message', function (event) {
    if (event.action = "showMenu") {
      var root = document.documentElement;
      actionContainer.fadeIn();
    } else {
      actionContainer.fadeOut();
    }
  })

  document.onkeyup = function (data) {
    if (data.which == 27) {
      if (actionContainer.is(":visible")) {
        sendData("ButtonClick", "fechar");
      }
    }
  };

  function sendData(name, data) {
    $.post("http://dz_nyse/" + name, JSON.stringify(data), function (
      datab
    ) {
      if (datab != "ok") {
        console.log(datab);
      }
    });
  }
})
