# frozen_string_literal: true

require_relative './controller/row_handler'
require_relative './controller/file_handler'

cod_empresa = '12345'
autorizacao_debito = '1231231231231'
data_debito = '09122021'
numero_sequencial = '123456'
numero_instalacao = '3004986950'
tipo_documento = 'CPF'
numero_documento = '00076486575204'

# Cabeçalho
header = CobRegistroHeaderAtualizacao.new(cod_empresa, autorizacao_debito, data_debito, numero_sequencial, '')

# Gerando 50 linhas de teste
rows = []
(1..50).each {
  rows << CobRegistroAutorizacaoDebito.new(cod_empresa, autorizacao_debito, '02', '01', '', numero_instalacao, tipo_documento, numero_documento, data_debito).as_string_row
}

# Trailer, obrigatorio em todos os arquivos
trailler = CobTrailler.new(cod_empresa, rows.count + 2)

arquivo = Coba01.new
arquivo.header = header
arquivo.rows = rows
arquivo.trailler = trailler
arquivo.generate_file('test', './output')
