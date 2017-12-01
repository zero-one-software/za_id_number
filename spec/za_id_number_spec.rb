require "spec_helper"
require 'pry'

describe ZAIDNumber do
  let(:valid_za_id)   { 7501151234085.to_s }
  let(:invalid_za_id) { 7501151234087.to_s }

  subject { described_class.new(valid_za_id) }

  it "has a version number" do
    expect(ZAIDNumber::Version::VERSION).not_to be nil
  end

  context "validation checks" do
    it "should only allow 13 character long id numbers" do
      expect(subject).to have_valid_length

      expect(described_class.new("12345678901234")).to_not have_valid_length
      expect(described_class.new("123456789012")).to_not   have_valid_length
    end

    it "should only allow digits" do
      expect(subject).to                                     have_only_digits
      expect(described_class.new("a#{valid_za_id}a")).to_not have_only_digits
    end

    it "should detect valid ZA ID number checksums" do
      expect(subject).to have_valid_checksum
    end

    it "should detect valid number checksums starting with 0" do
      num = "0001011234083"
      expect(described_class.new(num)).to have_valid_checksum
    end

    it "should detect invalid ZA ID number checksums" do
      expect(described_class.new(invalid_za_id)).to_not have_valid_checksum
    end

    it "should ensure ID numbers are only 13 digit numbers with valid checksums" do
      expect(subject).to be_valid

      expect(described_class.new("123456789015")).to_not  be_valid # all digits and has correct checksum, but too short
      expect(described_class.new("1234567A89012")).to_not be_valid # not all digits, but correct length
      expect(described_class.new(invalid_za_id)).to_not   be_valid # all digits, and correct length, but bad checksum
    end
  end
end
