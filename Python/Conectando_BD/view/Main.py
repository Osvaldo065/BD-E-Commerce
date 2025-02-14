import mysql.connector
from Controller.Criar_itens import Criar_itens

#Metodo Principal do código
if __name__ == "__main__":

    operacao_menus = Criar_itens()

    # Conectar ao banco
    conexao, cursor = operacao_menus.Conectar_banco()

    #Cadastrar contato cliente
    contato_id =  operacao_menus.Cadastrar_Contatos(conexao)

    #Cadastrar cliente 
    idCliente = operacao_menus.Cadastrar_Cliente(conexao, contato_id)

    #Realizando cadastro do pedido
    idPedido = operacao_menus.Criar_Pedido(conexao, contato_id, idCliente)

    #Realizando cadastro do fornecedor
    idfornecedor = operacao_menus.Criar_Fornecedor(conexao)

    #Realizando cadastro do produto
    idProduto = operacao_menus.Criar_Produtos(conexao, idPedido, idfornecedor, idCliente, contato_id)
  
    # Fechar a conexão
    operacao_menus.Fechar_conexao(conexao, cursor)

