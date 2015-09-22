require 'roo'

class Card < ActiveRecord::Base
  belongs_to :user
  has_many :label_cards, dependent: :destroy
  has_many :labels, through: :label_cards

  validates_presence_of :side_a, :side_b

  def self.import file, user
    spreadsheet = open_spreadsheet(file)

    accessible_attributes = ["side_a", "side_b", "proficiency_level"]

    header = spreadsheet.row 1

    if accessible_attributes.include? header[0]
      import_with_headers spreadsheet, header, accessible_attributes, user
    else
      import_without_headers spreadsheet, user
    end
  end

  private

  def self.import_with_headers spreadsheet, header, accessible_attributes, user
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      card = user.cards.build
      card.attributes = row.to_hash.slice *accessible_attributes
      card.save!
    end
  end

  def self.import_without_headers spreadsheet, user
    (1..spreadsheet.last_row).each do |i|
      card = user.cards.build side_a: spreadsheet.row(i)[0], side_b: spreadsheet.row(i)[1], proficiency_level: spreadsheet.row(i)[2]
      card.save!
    end
  end

  def self.open_spreadsheet file
    case File.extname file.original_filename
    when ".csv" then Roo::CSV.new file.path
    when ".xls" then Roo::Spreadsheet.open file.path, extension: :xls
    when ".xlsx" then Roo::Spreadsheet.open file.path, extension: :xlsx
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
