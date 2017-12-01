require 'za_id_number/version'
require 'luhn'

class ZAIDNumber
  REQUIRED_ID_LENGTH = 13

  attr_reader :id_number

  def initialize(id_num)
    @id_number = id_num.to_s
  end

  def valid?
    has_valid_length? &&
    has_only_digits?  &&
    has_valid_checksum?
  end

  def has_valid_checksum?
    Luhn.valid? @id_number
  end

  def has_valid_length?
    @id_number.length == REQUIRED_ID_LENGTH
  end

  def has_only_digits?
    @id_number.to_s.gsub(/\D*/, '') == @id_number.to_s
  end
end
