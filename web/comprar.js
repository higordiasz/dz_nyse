function AddRowToTable(data) {
    var tbody = document.getElementById("tableComprarBody");
    var nome = data.nome;
    var valor = data.valor;
    var qtd = data.qtd;
    var imagen = data.imagen;
    var vendedor = data.vendedor;
    var id = data.id;
    var row = document.createElement('tr');
    row.setAttribute("name", "linhaComprar")
    var row_1 = document.createElement('td');
    var row_2 = document.createElement('td');
    var row_3 = document.createElement('td');
    var row_4 = document.createElement('td');
    var row_5 = document.createElement('td');
    var row_6 = document.createElement('td');
    var row_7 = document.createElement('td');
    row_1.innerHTML = `<img src="${imagen}" alt = "" > `;
    row_2.innerHTML = `${nome}`;
    row_3.innerHTML = `${vendedor}`;
    row_4.innerHTML = `${qtd}`;
    row_5.innerHTML = `$${valor}`;
    row_6.innerHTML = `<input style="width: 140px;" id="${id}" max="${qtd}" type="number" class="form-control"
                            placeholder="Quantidade">`;
    row_7.innerHTML = `<button onclick="ComprarClick(this)" name="${id}" data-vendedor="${vendedor}" data-vendaID="${id}"
                            data-valor="${valor}" data-qtd="${qtd}" data-name="${nome}" data-toggle="tooltip" title=""
                            class="pd-setting-ed buy-button" data-original-title="Comprar"><i
                              class="fa fa-shopping-cart" aria-hidden="true"></i></button>`;
    row.appendChild(row_1);
    row.appendChild(row_2);
    row.appendChild(row_3);
    row.appendChild(row_4);
    row.appendChild(row_5);
    row.appendChild(row_6);
    row.appendChild(row_7);
    tbody.appendChild(row);
}

function ComprarClick(event) {
    var nome = event.getAttribute("data-name");
    var valor = event.getAttribute("data-valor");
    var qtd = event.getAttribute("data-qtd");
    var vendedor = event.getAttribute("data-vendedor");
    var id = event.getAttribute("data-vendaID");
    var element = document.getElementById(id);
    var qtdCompra = element.value;
    var data = {
        "vendedor": vendedor,
        "nome": nome,
        "valor": valor,
        "qtd": qtd,
        "id": id,
        "compra": qtdCompra
    }
    console.log(data);
}

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
            "id": i
        }
        AddRowToTable(data);
    }
}
