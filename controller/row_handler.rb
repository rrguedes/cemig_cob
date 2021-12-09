# frozen_string_literal: true

require_relative '../model/cemig_field'
require_relative '../model/cemig_file_row'

# Gerador do Header do arquivo COB - COBA01.TXT – MOVIMENTO DE ATUALIZAÇÃO - 1) REGISTRO : HEADER com base no manual versão Versão 2.4 - 06/10/2021
class CobRegistroHeaderAtualizacao < CemigRow
  attr_reader :campos

  def initialize(cod_empresa, numero_contrato, data_transmissao, numero_sequencial, versao)
    # Setando os valores dos campos recebidos no construtor
    @header_cod_empresa = cod_empresa
    @header_autorizacao_debito = ' ' * 15
    @header_movimento = '00'
    @header_subtipo = '00'
    @header_numero_sequencial = numero_sequencial
    @header_versao = versao != '' ? versao : ''
    @header_numero_contrato = numero_contrato
    @header_data_transmissao = data_transmissao

    # Configuracao dos campos do header do arquivo - incluir os arquivos no array na ordem de geracao conforme o manual

    f_cod_empresa = CemigField.new('COD_EMPRESA', 'N', 5, 1, 5)
    f_autorizacao_debito = CemigField.new('AUTORIZACAO_DEBITO', 'C', 15, 6, 20)
    f_movimento = CemigField.new('MOVIMENTO', 'N', 2, 21, 22)
    f_subtipo = CemigField.new('SUBTIPO', 'N', 2, 23, 24)
    f_nro_contrato = CemigField.new('NRO. DO CONTRATO', 'C', 13, 25, 37)
    f_data_transmissao = CemigField.new('DATA DE TRANSMISSAO', 'N', 8, 38, 45)
    f_numero_sequencial = CemigField.new('NUMERO SEQUENCIAL', 'N', 6, 46, 51)
    f_versao = CemigField.new('VERSAO', 'N', 4, 52, 55)
    f_brancos = CemigField.new('BRANCOS', 'C', 20, 56, 75)
    
    @campos = [f_cod_empresa, f_autorizacao_debito, f_movimento, f_subtipo, f_nro_contrato, f_data_transmissao, f_numero_sequencial, f_versao, f_brancos]

    # Setar os valores recebidos do construtor

    f_cod_empresa.field_value = @header_cod_empresa
    f_autorizacao_debito.field_value = ' ' * 15
    f_movimento.field_value = @header_movimento
    f_subtipo.field_value = @header_subtipo
    f_nro_contrato.field_value = @header_numero_contrato
    f_data_transmissao.field_value = @header_data_transmissao
    f_numero_sequencial.field_value = @header_numero_sequencial
    f_versao.field_value = @header_versao
    f_brancos.field_value = ' ' * 20
  end
end

# COBA01 – MOVIMENTO DE ATUALIZAÇÃO - REGISTRO: AUTORIZAÇÃO DE DÉBITO
class CobRegistroAutorizacaoDebito < CemigRow
  attr_accessor :cod_empresa, :autorizacao_debito, :movimento, :subtipo, :tipo_servico, :numero_instalacao, :tipo_documento, :numero_documento, :data_status, :brancos
  attr_reader :campos

  def initialize(cod_empresa, autorizacao_debito, movimento, subtipo, tipo_servico, numero_instalacao, tipo_documento, numero_documento, data_status)

    @cod_empresa = CemigField.new('COD_EMPRESA', 'N', 5, 1, 5)
    @cod_empresa.field_value = cod_empresa

    @autorizacao_debito = CemigField.new('AUTORIZACAO_DEBITO', 'C', 15, 6, 20)
    @autorizacao_debito.field_value = autorizacao_debito
    
    @movimento = CemigField.new('MOVIMENTO', 'N', 2, 21, 22)
    @movimento.field_value = movimento
  
    @subtipo = CemigField.new('SUBTIPO', 'N', 2, 23, 24)
    @subtipo.field_value = subtipo
    @subtipo.default_value = '01'

    @tipo_servico = CemigField.new('TIPO_SERVICO', 'C', 2, 25, 26)
    @tipo_servico.field_value = tipo_servico
    @tipo_servico.default_value = ' ' * 2

    # TODO: Tratar exceção da diferença entre os números da instalação nova e antiga conforme manual da Cemig
    @numero_instalacao = CemigField.new('INSTALACAO', 'N', 10, 27, 36)
    @numero_instalacao.field_value = numero_instalacao

    @tipo_documento = CemigField.new('TIPO_DOCUMENTO', 'C', 4, 37, 40)
    @tipo_documento.field_value = tipo_documento

    @numero_documento = CemigField.new('NUMERO_DOCUMENTO', 'C', 20, 41, 60)
    @numero_documento.field_value = numero_documento

    @data_status = CemigField.new('DATA_STATUS', 'N', 8, 61, 68)
    @data_status.field_value = data_status

    @brancos = CemigField.new('BRANCOS', 'C', 7, 69, 75)
    @brancos.field_value = ' ' * 7
    @brancos.default_value = ' ' * 7

    @campos = [@cod_empresa, @autorizacao_debito, @movimento, @subtipo, @tipo_servico, @numero_instalacao, @tipo_documento, @numero_documento, @data_status, @brancos]
  end
end

# COBA01.TXT - MOVIMENTO DE ATUALIZAÇÃO - 3 Registro Item de Débito
class CobRegistroItemDebito < CemigRow
  attr_reader :campos
  attr_accessor :cod_empresa, :autorizacao_debito, :movimento, :subtipo, :tipo_servico, :data_cobranca, :modalidade_cobranca, :total_parcelas

  def initialize(cod_empresa, autorizacao_debito, movimento, tipo_servico, data_cobranca, modalidade_cobranca, total_parcelas)
    @cod_empresa = CemigField.new('COD_EMPRESA', 'N', 5, 1, 5)
    @cod_empresa.field_value = cod_empresa
    
    @autorizacao_debito = CemigField.new('AUTORIZACAO_DEBITO', 'C', 15, 6, 20)
    @autorizacao_debito.field_value = autorizacao_debito

    @movimento = CemigField.new('MOVIMENTO','N', 2,  21, 22,)
    @movimento.field_value = movimento

    @subtipo = CemigField.new('SUBTIPO', 'N', 2,  23, 24)
    @subtipo.field_value = '02'

    @tipo_servico = CemigField.new('TIPO_SERVICO', 'N', 5, 25, 29)
    @tipo_servico.field_value = tipo_servico

    @data_cobranca = CemigField.new('DATA_COBRANCA', 'N', 8, 30, 37)
    @data_cobranca.field_value = data_cobranca

    @modalidade_cobranca = CemigField.new('MODALIDADE_COBRANCA', 'C', 1, 38, 38)
    @modalidade_cobranca.field_value = modalidade_cobranca

    @total_parcelas = CemigField.new('TOTAL_PARCELAS', 'N', 3, 39, 41)
    @total_parcelas.field_value = total_parcelas

    @brancos = CemigField.new('BRANCOS', 'C', 26, 50, 75)
    @brancos.field_value = ' ' * 26

    @campos = [@cod_empresa,
              @autorizacao_debito,
              @movimento,
              @subtipo,
              @tipo_servico,
              @grupo_parcelas,
              @quantidade_parcelas,
              @valor_parcelas,
              @brancos]
  end
end

# COBA01.TXT – ARQUIVO DE ATUALIZAÇÃO - 4 - REGISTRO: GRUPO DE PARCELAS
class CobRegistroGrupoParcelas < CemigRow
  attr_reader :campos
  attr_accessor :cod_empresa, :autorizacao_debito, :movimento, :subtipo, :tipo_servico, :grupo_parcelas, :quantidade_parcelas, :valor_parcelas

  def initialize(cod_empresa, autorizacao_debito, movimento, tipo_servico, grupo_parcelas, quantidade_parcelas, valor_parcelas)
    @cod_empresa = CemigField.new('COD_EMPRESA', 1, 5, 'N', 5)
    @cod_empresa.field_value = cod_empresa
    
    @autorizacao_debito = CemigField.new('AUTORIZACAO_DEBITO', 'C', 15, 6, 20)
    @autorizacao_debito.field_value = autorizacao_debito

    @movimento = CemigField.new('MOVIMENTO', 'N', 2, 21, 22)
    @movimento.field_value = movimento

    @subtipo = CemigField.new('SUBTIPO', 'N', 2,  23, 24)
    @subtipo.field_value = '03'

    @tipo_servico = CemigField.new('TIPO_SERVICO', 'N', 5, 25, 29)
    @tipo_servico.field_value = tipo_servico

    @grupo_parcelas = CemigField.new('GRUPO_PARCELAS', 'N', 2,  30, 31)
    @grupo_parcelas.field_value = grupo_parcelas

    @quantidade_parcelas = CemigField.new('QUANTIDADE_PARCELAS', 'N', 3,  32, 34)
    @quantidade_parcelas.field_value = quantidade_parcelas

    @valor_parcelas = CemigField.new('VALOR_PARCELAS', 'N', 15,  35, 49)
    @valor_parcelas.field_value = valor_parcelas

    @brancos = CemigField.new('BRANCOS', 'C', 26, 50, 75)
    @brancos.field_value = ' ' * 26

    @campos = [@cod_empresa,
              @autorizacao_debito,
              @movimento,
              @subtipo,
              @tipo_servico,
              @grupo_parcelas,
              @quantidade_parcelas,
              @valor_parcelas,
              @brancos]
  end

end

# COBA01.TXT - MOVIMENTO DE ATUALIZAÇÃO - 5) REGISTRO: ALTERAÇÃO DE PONTO DE CONSUMO
class CobRegistroAlteracaoPontoConsumo < CemigRow
  attr_reader :campos
  attr_accessor :cod_empresa,
                :autorizacao_debito, 
                :movimento, 
                :subtipo, 
                :tipo_servico, 
                :ponto_consumo_atual, 
                :ponto_consumo_novo, 
                :tipo_documento,
                :numero_documento,
                :data_alteracao

  def initialize(cod_empresa, autorizacao_debito, movimento, ponto_consumo_atual, ponto_consumo_novo, tipo_documento,numero_documento,data_alteracao)
    @cod_empresa = CemigField.new('COD_EMPRESA', 'N', 5, 1, 5)
    @cod_empresa.field_value = cod_empresa
    
    @autorizacao_debito = CemigField.new('AUTORIZACAO_DEBITO', 'C', 15, 6, 20,)
    @autorizacao_debito.field_value = autorizacao_debito

    @movimento = CemigField.new('MOVIMENTO', 'N', 2, 21, 22)
    @movimento.field_value = movimento

    @subtipo = CemigField.new('SUBTIPO', 'N', 2, 23, 24)
    @subtipo.field_value = '04'

    @tipo_servico = CemigField.new('TIPO_SERVICO', 'N', 5, 25, 29)
    @tipo_servico.field_value = '99'

    @ponto_consumo_atual = CemigField.new('PONTO_CONSUMO_ATUAL', 'N', 10, 27, 36)
    @ponto_consumo_atual.field_value = ponto_consumo_atual

    @ponto_consumo_novo = CemigField.new('PONTO_CONSUMO_ATUAL', 'N', 10, 37, 46 )
    @ponto_consumo_novo.field_value = ponto_consumo_novo

    @tipo_documento = CemigField.new('TIPO_DOCUMENTO', 'C', 4, 47, 50)
    @tipo_documento.field_value = tipo_documento

    @numero_documento = CemigField.new('NUMERO_DOCUMENTO', 'C', 20, 51, 70)
    @numero_documento.field_value = numero_documento

    @data_alteracao = CemigField.new('DATA_ALTERACAO', 'C', 5, 71, 75)
    @data_alteracao.field_value = ' ' * 5

    @campos = [@cod_empresa,
              @autorizacao_debito,
              @movimento,
              @subtipo,
              @tipo_servico,
              @ponto_consumo_atual,
              @ponto_consumo_novo,
              @numero_documento,
              @data_alteracao
             ]
  end
end

# COBA01.TXT - MOVIMENTO DE ATUALIZAÇÃO - 6) REGISTRO: TRAILLER
class CobTrailler < CemigRow
  attr_reader :campos
  attr_accessor :cod_empresa, :autorizacao_debito, :movimento, :subtipo, :somatorio

  def initialize(cod_empresa, somatorio)
    @cod_empresa = CemigField.new('COD_EMPRESA', 'N', 5, 1, 5)
    @cod_empresa.field_value = cod_empresa
    
    @autorizacao_debito = CemigField.new('AUTORIZACAO_DEBITO', 'C', 15, 6, 20,)
    @autorizacao_debito.field_value = '999999999999999'

    @movimento = CemigField.new('MOVIMENTO', 'N', 2, 21, 22)
    @movimento.field_value = '99'

    @subtipo = CemigField.new('SUBTIPO', 'N', 2, 23, 24)
    @subtipo.field_value = '99'

    @somatorio = CemigField.new('SOMATORIO', 'N', 15, 25, 39)
    @somatorio.field_value = somatorio

    @brancos = CemigField.new('BRANCOS', 'C', 36, 40, 75)
    @brancos.field_value = ' ' * 36

    @campos = [@cod_empresa, @autorizacao_debito, @movimento, @subtipo, @somatorio, @brancos]
  end
end