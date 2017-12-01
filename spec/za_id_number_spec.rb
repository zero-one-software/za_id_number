require "spec_helper"
require 'pry'

describe ZAIDNumber do
  let(:valid_za_id)   { 7501151234086 }
  let(:invalid_za_id) { 7501151234087 }

  it "has a version number" do
    expect(ZAIDNumber::VERSION).not_to be nil
  end

  context "validation checks" do
    it "should detect valid ZA ID numbers" do
      expect(described_class.new(valid_za_id)).to be_valid
    end

    it "should detect invalid ZA ID numbers" do
      expect(described_class.new(invalid_za_id)).to_not be_valid
    end
  end
end
