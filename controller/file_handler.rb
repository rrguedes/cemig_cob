# frozen_string_literal: true

require_relative '../model/cemig_file_row'

# Classe de Geracao do Arquivo COBA01.TXT Conforme Manual Cemig
class Coba01
  attr_accessor :header, :rows, :trailler

  # Metodo responsavel pela geracao do arquivo mesclando
  def generate_file(file_name, path)
    unless @header == nil? || @trailler == nil? || rows == ''
      full_file_path = "#{path}//#{file_name}.txt"
      File.open(full_file_path, 'w') { |f|
        f.write @header.as_string_row + "\n"
        @rows.each { |row| f.write row + "\n" }
        f.write @trailler.as_string_row
      }
      true
    end
    false
  end
end
