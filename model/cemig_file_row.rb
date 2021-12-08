# frozen_string_literal: true

require_relative './cemig_field'
require_relative '../utils/file_utils'

# Classe base das linhas dos arquivos
class CemigRow
  def _validate_header
    # TODO: Implementar validacao do header
  end

  def line_row
    field_list = @campos
    row = ''
    field_list.each do |field|
      row += Utils.formatted_value(field)
    end
    return row
  end
end