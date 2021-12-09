# frozen_string_literal: true

require_relative './cemig_field'
require_relative '../utils/file_util'

# Classe base das linhas dos arquivos
class CemigRow
  # Valida a linha
  def validate
    # TODO: Implementar validacao do header
  end

  # Retorna a linha formatada
  def as_string_row
    field_list = @campos
    row = ''
    field_list.each do |field|
      row += Utils.formatted_value(field)
    end
    return row
  end
end