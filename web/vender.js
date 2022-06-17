function AddRowToVenderTable(data) {
  var tbody = document.getElementById("tableVenderBody");
  var imagen = data.imagen;
  var nome = data.nome;
  var rendimento = data.rendimento;
  var qtd = data.qtd;
  var id = data.id;
  var row = document.createElement('tr');
  row.setAttribute("name", "linhaVender")
  var row_1 = document.createElement('td');
  var row_2 = document.createElement('td');
  var row_3 = document.createElement('td');
  var row_4 = document.createElement('td');
  var row_5 = document.createElement('td');
  var row_6 = document.createElement('td');
  var row_7 = document.createElement('td');
  row_1.innerHTML = `<img src="${imagen}" alt = "" > `;
  row_2.innerHTML = `${nome}`;
  row_3.innerHTML = `${rendimento}`;
  row_4.innerHTML = `${qtd}`;
  row_5.innerHTML = `<input style="width: 140px;" id="${id}Qtd" max="${qtd}" type="number" class="form-control"
                            placeholder="Quantidade">`;
  row_6.innerHTML = `<input style="width: 140px;" id="${id}Valor" max="2000000" type="number" class="form-control"
                            placeholder="Valor">`;
  row_7.innerHTML = `<button onclick="VenderClick(this)" name="${id}"
                            data-qtd="${qtd}" data-name="${nome}" data-rendimento="${rendimento}" data-toggle="tooltip" title=""
                            class="pd-setting-ed buy-button" data-original-title="Vender"><i
                              class="fa fa-cart-arrow-down" aria-hidden="true"></i></button>`;
  row.appendChild(row_1);
  row.appendChild(row_2);
  row.appendChild(row_3);
  row.appendChild(row_4);
  row.appendChild(row_5);
  row.appendChild(row_6);
  row.appendChild(row_7);
  tbody.appendChild(row);
}

function VenderClick(event) {
  var nome = event.getAttribute("data-name");
  var valor = document.getElementById(name + "Valor").value;
  var qtd = event.getAttribute("data-qtd");
  var qtdVenda = document.getElementById(name + "Qtd").value;
  var id = event.getAttribute("data-name");
  var data = {
    "nome": nome,
    "valor": valor,
    "qtd": qtd,
    "id": id,
    "qtdVenda": qtdVenda
  }
  console.log(data);
}
