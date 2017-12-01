require 'za_id_number/version'
require 'luhn'

class ZAIDNumber
  REQUIRED_ID_LENGTH = 13
  FEMALE_RANGE       = (0..4999)

  attr_reader :id_number

  def initialize(id_num)
    @id_number = id_num.to_s
  end

  def valid?
    has_valid_length? &&
    has_only_digits?  &&
    has_valid_date?   &&
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

  def has_valid_date?
    true if date_of_birth
  rescue ArgumentError
    false
  end

  def date_of_birth
    Date.parse("#{@id_number[0..1]}-#{@id_number[2..3]}-#{@id_number[4..5]}")
  end

  def gender
    female? ? :f : :m
  end

  def female?
    FEMALE_RANGE.include? @id_number[6..9].to_i
  end

  def male?
    !female?
  end
end
