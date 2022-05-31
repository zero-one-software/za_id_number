# frozen_string_literal: true

require 'za_id_number/version'
require 'luhn'
require 'date'

class ZAIDNumber
  REQUIRED_ID_LENGTH = 13
  FEMALE_RANGE       = (0..4999)
  MALE_RANGE         = (5000..9999)
  CITIZENSHIP_RANGE  = (0..1)
  ZA_CITIZEN         = 0
  PERMANENT_RESIDENT = 1

  attr_reader :id_number

  def initialize(id_num)
    @id_number = id_num.to_s.freeze
  end

  def valid?
    valid_length?      &&
    only_digits?       &&
    valid_date?        &&
    valid_citizenship? &&
    valid_checksum?
  end

  def valid_checksum?
    Luhn.valid? @id_number
  end

  def valid_length?
    @id_number.length == REQUIRED_ID_LENGTH
  end

  def only_digits?
    @id_number.to_s.gsub(/\D*/, '') == @id_number.to_s
  end

  def valid_date?
    date_of_birth ? true : false
  end

  def valid_citizenship?
    CITIZENSHIP_RANGE.include? @id_number[10].to_i
  end

  def date_of_birth
    Date.parse("#{@id_number[0..1]}-#{@id_number[2..3]}-#{@id_number[4..5]}")
  rescue ArgumentError
    nil
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

  def citizenship
    za_citizen? ? :za_citizen : :permanent_resident
  end

  def za_citizen?
    @id_number[10].to_i == ZA_CITIZEN
  end

  def permanent_resident?
    !za_citizen?
  end

  def ==(other)
    return false unless other.is_a?(ZAIDNumber)

    return id_number == other.id_number
  end
  alias eql? ==
end
