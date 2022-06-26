function AtualizarValoresOuro(ouro, userInfo) {
    document.getElementById('valor-atual-ouro').textContent = `Valor Atual: ${parseInt(ouro.atual).toLocaleString('en-US', { style: 'currency', currency: 'USD' })}`;
    document.getElementById('ouroQuantidade').textContent = userInfo.ouro;
    document.getElementById('tabela-ouro').innerHTML = "";
    PreencherTabelaOuro(ouro.cotacao10, ouro.cotacao09, ouro.cotacao08, ouro.cotacao07, ouro.cotacao06, ouro.cotacao05, ouro.cotacao04, ouro.cotacao03, ouro.cotacao02, ouro.cotacao01);
}

function AtualizarValoresOuroNoInfo(ouro) {
    document.getElementById('valor-atual-ouro').textContent = `Valor Atual: ${parseInt(ouro.atual).toLocaleString('en-US', { style: 'currency', currency: 'USD' })}`;
    document.getElementById('ouroQuantidade').textContent = 0;
    document.getElementById('tabela-ouro').innerHTML = "";
    PreencherTabelaOuro(ouro.cotacao10, ouro.cotacao09, ouro.cotacao08, ouro.cotacao07, ouro.cotacao06, ouro.cotacao05, ouro.cotacao04, ouro.cotacao03, ouro.cotacao02, ouro.cotacao01);
}

function VenderOuro(data) {
    console.log('Vender outo')
}

function ComprarOuro(data) {
    console.log('Comprar ouro')
}
