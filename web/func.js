$(function () {
  var actionContainer = $(".actionmenu");

  window.onload = function () {
    actionContainer.fadeOut();
    for (var i = 1; i < 10; i++) {
      var data = {
        "vendedor": "Dias Blackwell Tempest",
        "nome": "Maze Bank",
        "imagen": "https://pbs.twimg.com/profile_images/891404814818652160/bm4rOKWS_400x400.jpg",
        "valor": "10000",
        "qtd": "5000",
        "id": i,
        "rendimento": "1000"
      }
      AddRowToTable(data);
      AddRowToMyTable(data);
      AddRowToVenderTable(data);
    }
  };

  window.addEventListener('message', function (event) {
    if (event.data.action == "showMenu") {
      actionContainer.fadeIn();
    } else {
      actionContainer.fadeOut();
    }
  })

  document.onkeyup = function (data) {
    if (data.which == 27) {
      if (actionContainer.is(":visible")) {
        sendData("Close", "fechar");
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

  function AddRowToMyTable(data) {
    var tbody = document.getElementById("tableMyBody");
    var nome = data.nome;
    var qtd = data.qtd;
    var imagen = data.imagen;
    var rendimento = data.rendimento;
    var row = document.createElement('tr');
    row.setAttribute("name", "linhaMy")
    var row_1 = document.createElement('td');
    var row_2 = document.createElement('td');
    var row_3 = document.createElement('td');
    var row_4 = document.createElement('td');
    row_1.innerHTML = `<img src="${imagen}" alt = "" > `;
    row_2.innerHTML = `${nome}`;
    row_3.innerHTML = `$${rendimento}`;
    row_4.innerHTML = `${qtd}`;
    row.appendChild(row_1);
    row.appendChild(row_2);
    row.appendChild(row_3);
    row.appendChild(row_4);
    tbody.appendChild(row);
  }
})

function AtualizarClick() {
  var elements = document.getElementsByName("linhaComprar");
  var max = elements.length;
  for (var i = 0; i < max; i++) {
    elements[0].remove();
  }

  for (var i = 1; i < 5; i++) {
    var data = {
      "vendedor": "Dias Blackwell Tempest",
      "nome": "Maze Bank",
      "imagen": "https://pbs.twimg.com/profile_images/891404814818652160/bm4rOKWS_400x400.jpg",
      "valor": "10000",
      "qtd": "5000",
      "id": i,
      "rendimento": "1000"
    }
    AddRowToTable(data);
  }
}
