require 'za_id_number/version'
require 'luhn'

class ZAIDNumber
  VERSION = "0.1.0"

  attr_reader :id_number

  def initialize(id_num)
    @id_number = id_num
  end

  def valid?
    Luhn.valid? @id_number
  end
end
