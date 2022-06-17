function AddRowToExtratoTable(data) {
    var tbody = document.getElementById("tableExtratoBody");
    var imagen = data.imagen;
    var nome = data.nome;
    var valor = data.valor;
    var descricao = data.descricao;
    var tipo = data.tipo;
    var row = document.createElement('tr');
    row.setAttribute("name", "linhaExtrato")
    var row_1 = document.createElement('td');
    var row_2 = document.createElement('td');
    var row_3 = document.createElement('td');
    var row_4 = document.createElement('td');
    var row_5 = document.createElement('td');
    row_1.innerHTML = `<img src="${imagen}" alt = "" > `;
    row_2.innerHTML = `${nome}`;
    row_3.innerHTML = `${valor}`;
    row_4.innerHTML = `${descricao}`;
    if (tipo == 'Venda') {
        row_5.innerHTML = `<button data-toggle="tooltip" title="" class="pd-setting-ed buy-button" data-original-title="Vender"><i style="color: #00FF00;" class="fa fa-level-up" aria-hidden="true"></i></button>`;
    } else {
        row_5.innerHTML = `<button data-toggle="tooltip" title="" class="pd-setting-ed buy-button" data-original-title="Vender"><i style="color: #FF0000;" class="fa fa-level-up" aria-hidden="true"></i></button>`;
    }
    row.appendChild(row_1);
    row.appendChild(row_2);
    row.appendChild(row_3);
    row.appendChild(row_4);
    row.appendChild(row_5);
    tbody.appendChild(row);
}
