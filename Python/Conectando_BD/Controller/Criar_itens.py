import mysql.connector
from datetime import date

#Classe com os metodos para manipular

class Criar_itens():

    #Metodo para realizar a conexão com o Banco de dados 
    def Conectar_banco(self):
        
        conexao = mysql.connector.connect(host='localhost',
                                        database = 'Ecommerce_Dias',
                                        user = 'root',
                                        password = '')

        if conexao.is_connected():
            print("Conectado ao Banco de Dados com Sucesso!!")
            cursor = conexao.cursor()
            return conexao, cursor
    
    #Metodo para cadastrar os contatos dos clientes
    def Cadastrar_Contatos(self, conexao):

        #Recebendo as informações de contatos
        num_celular = input("Digite o seu numero de celular:").strip()
        num_celular_reserva = input("Digite o seu numero de celular reserva:").strip() 
        email_cliente = input("Digite o seu email:").strip()

        #Query para inserir as informações no BD
        con_sql = "INSERT INTO Contatos(num_celular, num_celular_reserva, email_cliente) VALUES (%s, %s, %s)"
        valores = (num_celular, num_celular_reserva, email_cliente)

        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        conexao.commit()

        contato_id = cursor.lastrowid

        print(cursor.rowcount, "Contato cadastrado com sucesso!!")

        return contato_id


    #Metodo para realizar a inserção dos dados 
    def Cadastrar_Cliente(self, conexao, contato_id):

        #Solicitando as informações para cadastrar o cliente

        nome_cliente = input("Cadastre o seu nome: ").strip()
        endereco_cliente = input("Cadastre seu endereço:").strip()
        cpf_cliente = input("Informe seu CPF:").strip()

        #Condição para verificar se o cliente tiver cpf não cadastra um CNPJ
        if cpf_cliente == "":
            
            cnpj_cliente = input("Informe o seu CNPJ:").strip()
        else:
            cnpj_cliente = " "

        #Query para inserir dados na tabela
        con_sql = "INSERT INTO Cliente(nome_cliente, endereco_cliente, CPF, CNPJ, contatos_IdContatos) VALUES (%s, %s, %s, %s, %s)"
        valores = (nome_cliente, endereco_cliente, cpf_cliente, cnpj_cliente, contato_id)

        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        conexao.commit()

        idCliente = cursor.lastrowid

        print(cursor.rowcount, f"Cliente {nome_cliente} cadastrado com sucesso!!")

        return idCliente


    #Metodo para Criar Pedido
    def Criar_Pedido(self, conexao, contato_id, idCliente):

        #Solicitando os dados do Pedido 
        nome_produto = input("Informe o produto desejado:").strip()
        quantidade_pedida = input("Digite a quantidade do pedido:").strip()
        descricao_pedido = input("Digite a descrição do pedido:").strip()
        data_pedido = date.today() #Recebe a data atual
        fornecedor = input("Digite o nome do fornecedor:").strip()

        #Comando para inserir os dados na tabela
        con_sql = "INSERT INTO Pedido(nome_produto, quantidade_pedido, descricao_pedido, data_pedido, fornecedor, Cliente_idCliente, Cliente_Contatos_idContatos)VALUES(%s, %s, %s, %s, %s, %s, %s)"
        valores = (nome_produto, quantidade_pedida, descricao_pedido, data_pedido, fornecedor, idCliente, contato_id)

        #Executando as informações
        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        conexao.commit()

        idPedido = cursor.lastrowid

        print(cursor.rowcount, f"Pedido {idPedido} criado com sucesso!!")

        return idPedido

    def Criar_Fornecedor(self, conexao, nome_fornecedor):
        
        #Solciitando os dados do fornecedor
        nome_fornecedor = input("Digite o nome do fornecedor:").strip()
        cnpj_fornecedor = input("Digite o CNPJ:").strip()
        endereco_fornecedor = input("Digite o endereço:").strip()

        #Comando para inserir os dados do pedido
        con_sql = "INSERT INTO fornecedor(razao_social, CNPJ, endereco)VALUES(%s, %s, %s)"
        valores = (nome_fornecedor, cnpj_fornecedor, endereco_fornecedor)

        #Executando as informações
        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        conexao.commit()

        idfornecedor = cursor.lastrowid

        print("Fornecedor Cadastrado com sucesso!!")

        return idfornecedor
    

    def Criar_Produtos(self, conexao, idfornecedor, contato_id, idCliente, idPedido):

        #Solicitando os dados do produtos
        nome_produto = input("Digite o nome do produto:").strip()
        descricao_produto = input("Digite a descrição do produto:").strip()
        lote_prodtuo = input("Digite o lote do produto:").strip()
        data_fabricacao = input("Informe a data de fabricação:").strip()
        data_validade = input("Informe a data de validade:").strip()
        categoria_produto = input("Digite a categoria do produto:").strip()

        #Comando para inserir os dados do Produto
        con_sql = "INSERT INTO Produtos(nome_produto, descricao_produto, lote_produto, data_fabricacao, data_validade, Pedidos_idPedidos, Pedidos_Cliente_idCliente, Pedidos_Cliente_Contatos_idContatos, fornecedor_idfornecedor, categori)VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        valores = (nome_produto, descricao_produto, lote_prodtuo, data_fabricacao, data_validade, idPedido, idCliente, contato_id, idfornecedor, categoria_produto)

        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        conexao.commit()

        print("Produto cadastrado com sucesso!!")

        idProduto = cursor.lastrowid

        return idProduto
    
    #Metodo para cadastrar estoque
    def Cadastrar_Estoque(self, conexao, idProduto, idPedido, idCliente, contato_id, idfornecedor):

        #Solicitando os dados do estoque
        quantidade_estoque = input("Digite a quantidade do estoque:").strip()

        #Comando para inserir os dados
        con_sql = "INSERT INTO produtos_em_estoque(Produtos_idProdutos, Produtos_Pedidos_idPedidos, Produtos_Pedidos_Cliente_idCliente, Produtos_Pedidos_Cliente_Contatos_idContatos, Produtos_fornecedor_idfornecedor, quantidade_produto)VALUES(%s, %s, %s, %s, %s, %s)"
        valores = (idProduto, idPedido, idCliente, contato_id, idfornecedor, quantidade_estoque)

        #Executando o comando 
        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        #Exibir mensagem de sucesso
        print("Estoque cadastrado com sucesso!!")

        conexao.commit()

        idProdutos_estoque = cursor.lastrowid

        return idProdutos_estoque
    
    #Metodo para criar ordem de serviço
    def Criar_ordem_servico(self, conexao, idNota_Fiscal, nome_fornecedor):
        #Solicitando os dados
        descricao_ordem = input("Digite a descrição da OS:").strip()
        data_ordem = date.today()

        #Comando para inserir
        con_sql = "INSERT INTO ordem_servico(descricao_ordem, fornecedor, data_ordem, Nota_Fiscal_idNota_Fiscal)VALUES(%s, %s, %s, %s)"
        valores = (descricao_ordem, nome_fornecedor, data_ordem, idNota_Fiscal)

        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        print("Ordem criada com sucesso!!")

        conexao.commit()

        idordem_servico = cursor.lastrowid

        return idordem_servico

        
        

    #Metodo para passar dados para ordem de serviço
    def Obter_ordem_servico(self, conexao, idProduto, idPedido, idCliente, contato_id, idOrdem_servico):

        con_sql = "INSERT INTO produtos_tem_ordem(Produtos_idProdutos2, Produtos_Pedidos_idPedidos2, Produtos_Pedidos_Cliente_idCliente2, Produtos_Pedidos_Cliente_Contatos_idContatos2, ordem_servico_idordem_servico)"
        valores = (idProduto, idPedido, idCliente, contato_id, idOrdem_servico)

        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        print("Produto tem Ordem OK!!")

        conexao.commit()

        idProdutos_tem_ordem = cursor.lastrowid

        return idProdutos_tem_ordem


    #metodo para criar transportadora
    def Criar_transportadora(self, conexao):
        #Solicitando os dados
        nome_transportadora = input("Digite o nome da transportadora:").strip()
        endereco_transportado = input("Digite o endereço da transportado: ").strip()
        cnpj_transportadora = input("Digite o CNPJ da transportadora:").strip()
        telefone = input("Digite o telefone da transportadora:").strip()

        #Comando para inserir os dados
        con_sql = "INSERT INTO transportadora(nome_razao_social, endereco, CNPJ_transportadora, telefone_transportadora)VALUES(%s, %s, %s, %s)"
        valores = (nome_transportadora, endereco_transportado, cnpj_transportadora, telefone)

        #Executando o comando
        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        #Exibindo mensagem de sucesso 
        print("Transportadora cadastrada com sucesso!!") 

        conexao.commit()   

        idtransportadora = cursor.lastrowid

        return idtransportadora
    
    #Metodo de criar Nota fiscal
    def Criar_Nota_fiscal(self, conexao, idtransportadora, idtipo_pagamento):

        #Solicitando os dados 
        data_emissao = input("Informe a data de emissão da NF:").strip()
        nome_destinatario = input("Digite o nome do destinatario:").strip()
        destinatario_CPF_CPNJ = input("Digite o documento do destinatario:").strip()#O cliente pode ser PJ ou PF
        nome_remetente = input("Digite o nome do remetente:").strip()
        cnpj_remetente =input("Digite o CNPJ do remetente:").strip()
        valor_venda = input("Digite o valor da venda:").strip()
        numero_serie = input("Digite o número de série:").strip()
        numero_NF = input("Digite o número da NF:").strip()

        #Comando para registrar os dados
        con_sql = "INSERT INTO nota_fiscal(data_emissao, nome_destinatario, CNPJ_CPF_destinatario, nome_remetente, CNPJ_CPF_remetente, valor_venda, transportadora_idtransportadora2, tipo_pagamento_idtipo_pagamento, Numero_NF, Serie_NF)VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) "       
        valores = (data_emissao, nome_destinatario, destinatario_CPF_CPNJ, nome_remetente, cnpj_remetente, valor_venda, idtransportadora, idtipo_pagamento, numero_NF, numero_serie)

        #Executando
        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        #Exibindo mensagem de sucesso 
        print("Nota cadastrada com sucesso!!")

        conexao.commit()

        idNota_Fiscal = cursor.lastrowid

        return idNota_Fiscal

    #Metodo para registrar entrega
    def Registrar_entrega(self, conexao, idtransportadora):
        #Solicitando os dados
        cod_rastreio = input("Informe o código de rastreio:").strip()
        status = input("Informe o status da entrega:").strip()

        #comando para inserir os dados
        con_sql = "INSERT INTO entrega(cod_rastreio, status, transportadora_idtransportadora)VALUES(%s, %s, %s)"
        valores = (cod_rastreio, status, idtransportadora)

        #Executando
        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        #Exibindo mensgame de sucesso
        print("Código de rastreio cadastrado!!")

        conexao.commit()

        idEntrega = cursor.lastrowid

        return idEntrega
    
    #Metodo para cadastrar o tipo de pagamento
    def Cadastrar_pagamento(self, conexao):
        #Solicitando os dados
        opcao_pagamento = int(input("Qual a forma de pagamento?\n[1]Boleto\n[2]PIX\n[3]Cartão"))

        #Condicional para verificar os pagamentos
        if opcao_pagamento == 1:
            boleto = input("Digite o código do boleto:").strip()
        else:
            boleto = " "
        if opcao_pagamento == 2:
            pix = input("Digite a chave do pix:").strip()
        else:
            pix = " "
        if opcao_pagamento == 3:
            cartao = input("Digite o número do cartão de crédito:").strip()
            nome = input("Digite o nome conforme o cartão:").strip()
            data_vencimento = input("Digite a data de vencimento:").strip()
        else:
            cartao = " "
            nome = " "
            data_vencimento = " "
        
        #Comando para inserir
        con_sql = "INSERT INTO tipo_pagamento(boleto, pix, num_cartao, data_vencimento, nome_cartao,)VALUES(%s, %s, %s, %s, %s)"
        valores = (boleto, pix, cartao, data_vencimento, nome)

        #Executando 
        cursor = conexao.cursor()
        cursor.execute(con_sql, valores)

        #Exibindo mensagem de sucesso
        print("Pagamento cadastrado!")

        conexao.commit()

        idtipo_pagamento = cursor.lastrowid

        return idtipo_pagamento    

    
    #Metodo para encerrar a conexão como BD
    def Fechar_conexao(self, conexao, cursor):

        cursor.close()
        conexao.close()

        print("Conexão fechada com sucesso.")

        

    


