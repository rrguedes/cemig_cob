# frozen_string_literal: true

require_relative './controller/file_generator'

test_header = CobHeaderAtualizacao.new('12345', '', '00', '00', '1231231231231', '06122021', '123456', '')
test_registro = CobRegistroAutorizacaoDebito.new('12345','000000000000001','02','01', '','1234567891','CPF', '00076486575204','07122021')

puts "Linha Header de Atualizacao: #{test_header.line_row} \n"
puts "Linha de Registro de Autorizacao de Debito: #{test_registro.line_row} \n"
