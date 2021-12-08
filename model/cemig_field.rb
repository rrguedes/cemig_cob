# frozen_string_literal: true

# Classe base para os campos utilizados nos arquivos COB da Cemig
class CemigField
  # attr_accessor @default_value

  attr_reader :field_name, :field_type, :field_length, :field_start_pos, :field_final_pos
  attr_accessor :default_value, :field_value

  # Construtor da classe de criação do campo
  def initialize(field_name, field_type, field_length, field_start_pos, field_final_pos)
    @field_name = field_name
    @field_type = field_type
    @field_length = field_length
    @field_start_pos = field_start_pos
    @field_final_pos = field_final_pos
  end

  # Validator do Campo
  def validates
    validated = field_value.equal?('').nil? ? false : true
    !(field_value.to_s.length >= 1 && field_value.to_s.length <= field_length) ? false : validated
  end
end
