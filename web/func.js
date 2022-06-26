$(function () {
  var actionContainer = $(".actionmenu");

  window.onload = function () {
    actionContainer.fadeOut();
  };

  window.addEventListener('message', function (event) {
    if (event.data.action == "showMenu") {
      actionContainer.fadeIn();
      ClearRowComprarTable();
      ClearRowMyTable();
      ClearRowVenderTable();
      ClearRowExtratoTable();
      var acoes = event.data.acoes;
      var myAcoes = event.data.myAcoes;
      var myExtrato = event.data.myExtrato;
      var comprarAcoes = event.data.comprarAcoes;
      var ouroValues = event.data.ouro;
      var userInfo = event.data.userInfo;
      if (acoes != undefined) {
        if (userInfo != undefined) {
          if (myAcoes != undefined) {
            var rendimentos = 0;
            var qtdAcoes = 0;
            for (var i = 0; i < myAcoes.length; i++) {
              if (myAcoes[i].quantidade > 0) {
                var index = -1;
                for (var j = 0; j < acoes.length; j++) {
                  if (acoes[j].id == myAcoes[i].id_acao)
                    index = j;
                }
                if (index > -1) {
                  rendimentos += (parseInt(acoes[index].rendimento) * parseInt(myAcoes[i].quantidade));
                  qtdAcoes += parseInt(myAcoes[i].quantidade);
                  var data = {
                    'imagen': acoes[index].image,
                    'nome': acoes[index].nome,
                    'qtd': myAcoes[i].quantidade,
                    'rendimento': parseInt(acoes[index].rendimento).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                  };
                  var dataVender = {
                    'imagen': acoes[index].image,
                    'nome': acoes[index].nome,
                    'qtd': myAcoes[i].quantidade,
                    'rendimento': parseInt(acoes[index].rendimento).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                    'id': acoes[index].id
                  }
                  AddRowToMyTable(data);
                  AddRowToVenderTable(dataVender);
                }
              }
            }
            this.document.getElementById('geralRendimentos').textContent = rendimentos.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
            this.document.getElementById('geralDispesas').textContent = '-' + parseInt(userInfo.despesas).toLocaleString('en-US', { style: 'currency', currency: 'USD' });
            this.document.getElementById('geralBalanco').textContent = (parseInt(userInfo.rendimentos) - parseInt(userInfo.despesas)).toLocaleString('en-US', { style: 'currency', currency: 'USD' });
            this.document.getElementById('geralAcoes').textContent = qtdAcoes;
            this.document.getElementById('extratoDisponivel').textContent = (parseInt(userInfo.saldo_disponivel)).toLocaleString('en-US', { style: 'currency', currency: 'USD' });
          }
          if (myExtrato != undefined) {
            for (var i = myExtrato.length - 1; i > -1; i--) {
              if (myExtrato[i].id_acao == "saque") {
                var data = {
                  'imagen': "https://imgur.com/6HYFTDz.jpeg",
                  'nome': "Saque",
                  'valor': parseInt(myExtrato[i].valor).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                  'descricao': myExtrato[i].descricao,
                  'tipo': myExtrato[i].tipo,
                };
                AddRowToExtratoTable(data);
              }
              else {
                var index = -1;
                for (var j = 0; j < acoes.length; j++) {
                  if (acoes[j].id == myExtrato[i].id_acao)
                    index = j;
                }
                if (index > -1) {
                  var data = {
                    'imagen': acoes[index].image,
                    'nome': acoes[index].nome,
                    'valor': parseInt(myExtrato[i].valor).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                    'descricao': myExtrato[i].descricao,
                    'tipo': myExtrato[i].tipo,
                  };
                  AddRowToExtratoTable(data);
                }
              }
            }
          }
          if (comprarAcoes != undefined) {
            for (var i = 0; i < comprarAcoes.length; i++) {
              if (comprarAcoes[i].quantidade > 0) {
                var index = -1;
                for (var j = 0; j < acoes.length; j++) {
                  if (acoes[j].id == comprarAcoes[i].id_acao)
                    index = j;
                }
                if (index > -1) {
                  var data = {
                    'idAcao': comprarAcoes[i].id_acao,
                    'imagen': acoes[index].image,
                    'nome': acoes[index].nome,
                    'qtd': comprarAcoes[i].quantidade,
                    'valor': parseInt(comprarAcoes[i].valor).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                    'vendedor': comprarAcoes[i].vendedor,
                    'id': comprarAcoes[i].id,
                    'rendimento': parseInt(acoes[index].rendimento).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                  };
                  if (userInfo.player_id == comprarAcoes[i].player_id)
                    AddRowToTable(data, true);
                  else
                    AddRowToTable(data, true);
                }
              }
            }
          }
          if (ouroValues != undefined) {
            AtualizarValoresOuro(ouroValues, userInfo);
          }
        }
        else {
          if (comprarAcoes != undefined) {
            for (var i = 0; i < comprarAcoes.length; i++) {
              if (comprarAcoes[i].quantidade > 0) {
                var index = -1;
                for (var j = 0; j < acoes.length; j++) {
                  if (acoes[j].id == comprarAcoes[i].id_acao)
                    index = j;
                }
                if (index > -1) {
                  var data = {
                    'idAcao': comprarAcoes[i].id_acao,
                    'imagen': acoes[index].image,
                    'nome': acoes[index].nome,
                    'qtd': comprarAcoes[i].quantidade,
                    'valor': parseInt(comprarAcoes[i].valor).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                    'vendedor': comprarAcoes[i].vendedor,
                    'id': comprarAcoes[i].id,
                    'rendimento': parseInt(acoes[index].rendimento).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                  };
                  AddRowToTable(data);
                }
              }
            }
          }
          if (ouroValues != undefined) {
            AtualizarValoresOuroNoInfo(ouroValues);
          }
        }
      }
    } else {
      if (event.data.action == "atualizar") {
        ClearRowComprarTable();
        ClearRowMyTable();
        ClearRowVenderTable();
        ClearRowExtratoTable();
        var acoes = event.data.acoes;
        var myAcoes = event.data.myAcoes;
        var myExtrato = event.data.myExtrato;
        var comprarAcoes = event.data.comprarAcoes;
        var ouroValues = event.data.ouro;
        var userInfo = event.data.userInfo;
        if (acoes != undefined) {
          if (userInfo != undefined) {
            if (myAcoes != undefined) {
              var rendimentos = 0;
              var qtdAcoes = 0;
              for (var i = 0; i < myAcoes.length; i++) {
                if (myAcoes[i].quantidade > 0) {
                  var index = -1;
                  for (var j = 0; j < acoes.length; j++) {
                    if (acoes[j].id == myAcoes[i].id_acao)
                      index = j;
                  }
                  if (index > -1) {
                    rendimentos += (parseInt(acoes[index].rendimento) * parseInt(myAcoes[i].quantidade));
                    qtdAcoes += parseInt(myAcoes[i].quantidade);
                    var data = {
                      'imagen': acoes[index].image,
                      'nome': acoes[index].nome,
                      'qtd': myAcoes[i].quantidade,
                      'rendimento': parseInt(acoes[index].rendimento).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                    };
                    var dataVender = {
                      'imagen': acoes[index].image,
                      'nome': acoes[index].nome,
                      'qtd': myAcoes[i].quantidade,
                      'rendimento': parseInt(acoes[index].rendimento).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                      'id': acoes[index].id
                    }
                    AddRowToMyTable(data);
                    AddRowToVenderTable(dataVender);
                  }
                }
              }
              this.document.getElementById('geralRendimentos').textContent = rendimentos.toLocaleString('en-US', { style: 'currency', currency: 'USD' });
              this.document.getElementById('geralDispesas').textContent = '-' + parseInt(userInfo.despesas).toLocaleString('en-US', { style: 'currency', currency: 'USD' });
              this.document.getElementById('geralBalanco').textContent = (parseInt(userInfo.rendimentos) - parseInt(userInfo.despesas)).toLocaleString('en-US', { style: 'currency', currency: 'USD' });
              this.document.getElementById('geralAcoes').textContent = qtdAcoes;
              this.document.getElementById('extratoDisponivel').textContent = (parseInt(userInfo.saldo_disponivel)).toLocaleString('en-US', { style: 'currency', currency: 'USD' });
            }
            if (myExtrato != undefined) {
              for (var i = myExtrato.length - 1; i > -1; i--) {
                if (myExtrato[i].id_acao == "saque") {
                  var data = {
                    'imagen': "https://imgur.com/6HYFTDz.jpeg",
                    'nome': "Saque",
                    'valor': parseInt(myExtrato[i].valor).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                    'descricao': myExtrato[i].descricao,
                    'tipo': myExtrato[i].tipo,
                  };
                  AddRowToExtratoTable(data);
                }
                else {
                  var index = -1;
                  for (var j = 0; j < acoes.length; j++) {
                    if (acoes[j].id == myExtrato[i].id_acao)
                      index = j;
                  }
                  if (index > -1) {
                    var data = {
                      'imagen': acoes[index].image,
                      'nome': acoes[index].nome,
                      'valor': parseInt(myExtrato[i].valor).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                      'descricao': myExtrato[i].descricao,
                      'tipo': myExtrato[i].tipo,
                    };
                    AddRowToExtratoTable(data);
                  }
                }
              }
            }
            if (comprarAcoes != undefined) {
              for (var i = 0; i < comprarAcoes.length; i++) {
                if (comprarAcoes[i].quantidade > 0) {
                  var index = -1;
                  for (var j = 0; j < acoes.length; j++) {
                    if (acoes[j].id == comprarAcoes[i].id_acao)
                      index = j;
                  }
                  if (index > -1) {
                    var data = {
                      'idAcao': comprarAcoes[i].id_acao,
                      'imagen': acoes[index].image,
                      'nome': acoes[index].nome,
                      'qtd': comprarAcoes[i].quantidade,
                      'valor': parseInt(comprarAcoes[i].valor).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                      'vendedor': comprarAcoes[i].vendedor,
                      'id': comprarAcoes[i].id,
                      'rendimento': parseInt(acoes[index].rendimento).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                    };
                    if (userInfo.player_id == comprarAcoes[i].player_id)
                      AddRowToTable(data, true);
                    else
                      AddRowToTable(data, true);
                  }
                }
              }
            }
            if (ouroValues != undefined) {
              AtualizarValoresOuro(ouroValues, userInfo);
            }
          }
          else {
            if (comprarAcoes != undefined) {
              for (var i = 0; i < comprarAcoes.length; i++) {
                if (comprarAcoes[i].quantidade > 0) {
                  var index = -1;
                  for (var j = 0; j < acoes.length; j++) {
                    if (acoes[j].id == comprarAcoes[i].id_acao)
                      index = j;
                  }
                  if (index > -1) {
                    var data = {
                      'idAcao': comprarAcoes[i].id_acao,
                      'imagen': acoes[index].image,
                      'nome': acoes[index].nome,
                      'qtd': comprarAcoes[i].quantidade,
                      'valor': parseInt(comprarAcoes[i].valor).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                      'vendedor': comprarAcoes[i].vendedor,
                      'id': comprarAcoes[i].id,
                      'rendimento': parseInt(acoes[index].rendimento).toLocaleString('en-US', { style: 'currency', currency: 'USD' }),
                    };
                    AddRowToTable(data);
                  }
                }
              }
            }
            if (ouroValues != undefined) {
              AtualizarValoresOuroNoInfo(ouroValues);
            }
          }
        }
      }
      else {
        actionContainer.fadeOut();
      }
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

  function ClearRowMyTable() {
    var linhas = document.getElementsByName('linhaMy');
    var max = linhas.length;
    for (var i = 0; i < max; i++) {
      linhas[0].remove();
    }
  }

  function ClearRowComprarTable() {
    var linhas = document.getElementsByName('linhaComprar');
    var max = linhas.length;
    for (var i = 0; i < max; i++) {
      linhas[0].remove();
    }
  }

  function ClearRowVenderTable() {
    var linhas = document.getElementsByName('linhaVender');
    var max = linhas.length;
    for (var i = 0; i < max; i++) {
      linhas[0].remove();
    }
  }

  function ClearRowExtratoTable() {
    var linhas = document.getElementsByName('linhaExtrato');
    var max = linhas.length;
    for (var i = 0; i < max; i++) {
      linhas[0].remove();
    }
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
    row_3.innerHTML = `${rendimento}`;
    row_4.innerHTML = `${qtd}`;
    row.appendChild(row_1);
    row.appendChild(row_2);
    row.appendChild(row_3);
    row.appendChild(row_4);
    tbody.appendChild(row);
  }
})

function PreencherTabelaOuro(v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) {
  var chart = c3.generate({
    bindto: '#tabela-ouro',
    data: {
      columns: [
        ['Valor', v1, v2, v3, v4, v5, v6, v7, v8, v9, v10]
      ],
      types: {
        Valor: 'area',
      },
      colors: {
        Valor: '#f1f1f1',
      },
    },
    size: {
      height: 360
    },
    color: {
      pattern: ["transparent", "#01d8dd", "#ff6400", "#ff56d5", "#808080"]
    },
    tooltip: {
      contents: function (d, defaultTitleFormat, defaultValueFormat, color) {
        return "<div class='c3-tooltip-div'><font color='#f1f1f1'> $ " + d[0].value + "</font></div>";
      }
    },
    legend: {
      show: false,
    }
  });
}

function AtualizarClick() {
  sendData2("Atualizar", "atualizar");
}

function Sacar(data) {
  var valor = document.getElementById('sacar').value;
  var data = {
    "valor": valor
  }
  sendData2("Sacar", data);
}

function sendData2(name, data) {
  $.post("http://dz_nyse/" + name, JSON.stringify(data), function (
    datab
  ) {
    if (datab != "ok") {
      console.log(datab);
    }
  });
}

function valorToInt(valor) {
  var arr = valor.split('.');
  var retorno = arr[0].replace('$', '').replace(',', '');
  return retorno;
}
