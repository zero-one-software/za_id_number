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
      expect(subject).to be_valid_length

      expect(described_class.new("12345678901234")).to_not be_valid_length
      expect(described_class.new("123456789012")).to_not   be_valid_length
    end

    it "should only allow digits" do
      expect(subject).to                                     be_only_digits
      expect(described_class.new("a#{valid_za_id}a")).to_not be_only_digits
    end

    it "should only allow ID numbers with valid dates" do
      expect(subject).to                                  be_valid_date
      expect(described_class.new("7513331234083")).to_not be_valid_date
    end

    it "should only allow valid citizenship values" do
      expect(subject).to                                  be_valid_citizenship
      expect(described_class.new("7501151234283")).to_not be_valid_citizenship
    end

    it "should detect valid ZA ID number checksums" do
      expect(subject).to be_valid_checksum
    end

    it "should detect valid number checksums starting with 0" do
      num = "0001011234083"
      expect(described_class.new(num)).to be_valid_checksum
    end

    it "should detect invalid ZA ID number checksums" do
      expect(described_class.new(invalid_za_id)).to_not be_valid_checksum
    end

    it "should ensure ID numbers are only 13 digit numbers with completely valid data embedded" do
      expect(subject).to be_valid

      expect(described_class.new("123456789015")).to_not  be_valid # all digits and has correct checksum, but too short
      expect(described_class.new("1234567A89012")).to_not be_valid # not all digits, but correct length
      expect(described_class.new("7513331234083")).to_not be_valid # all good, except date is bad.
      expect(described_class.new("7501151234283")).to_not be_valid # all good, citizenship is bad
      expect(described_class.new(invalid_za_id)).to_not   be_valid # all digits, and correct length, but bad checksum
    end
  end

  context "date parsing" do
    it "should extract a date of birth" do
      expect(subject.date_of_birth).to eq Date.parse('1975-01-15')
    end
  end

  context "gender parsing" do
    let(:female_id) { described_class.new 7501151234085.to_s }
    let(:male_id)   { described_class.new 7501156000085.to_s }

    it "should detect males" do
      expect(male_id).to        be_male
      expect(male_id.gender).to eq :m
    end

    it "should detect females" do
      expect(female_id).to        be_female
      expect(female_id.gender).to eq :f
    end
  end

  context "citizenship parsing" do
    let(:za_citizen)         { described_class.new 7501151234085.to_s }
    let(:permanent_resident) { described_class.new 7501151234184.to_s }

    it "should detect ZA citizens" do
      expect(za_citizen).to             be_za_citizen
      expect(za_citizen.citizenship).to eq :za_citizen
    end

    it "should detect permanent residents" do
      expect(permanent_resident).to             be_permanent_resident
      expect(permanent_resident.citizenship).to eq :permanent_resident
    end
  end
end
