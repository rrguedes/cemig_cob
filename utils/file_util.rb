# frozen_string_literal: true

require_relative '../model/cemig_field'

# Utilitários estáticos para manipulação dos arquivos, linhas e campos
class Utils
  # Retorna o valor formatado com base no tipo do campo e comprimento
  def self.formatted_value(field)
    
    field_value = field.field_value
    field_type = field.field_type
    field_length = field.field_length

    if field_value.to_s.nil? || (field_type.to_s != 'N' && field_type.to_s != 'C')
      false
    else
      if field_value.to_s.length > field_length
        false
      else
        if field_type == 'C'
          blank_spaces_to_add = field_length - field_value.to_s.length
          field_value.to_s + ' ' * blank_spaces_to_add
        else
          if field_type == 'N'
            zeros_to_add = field_length - field_value.to_s.length
            '0' * zeros_to_add + field_value.to_s
          end
        end
      end
    end
  end
end
