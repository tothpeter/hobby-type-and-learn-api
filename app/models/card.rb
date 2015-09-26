require 'roo'

class Card < ActiveRecord::Base
  belongs_to :user
  has_many :label_cards, dependent: :destroy
  has_many :labels, through: :label_cards

  validates_presence_of :side_a, :side_b

  def self.preview_import file
    spreadsheet = open_spreadsheet(file)

    cards = []
    headers = spreadsheet.row 1
    accessible_attributes = ["side_a", "side_b", "proficiency_level"]

    if accessible_attributes.include? headers[0]
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[headers, spreadsheet.row(i)].transpose]
        cards << { sideA: row["side_a"], sideB: row["side_b"], proficiencyLevel: row["proficiency_level"] }
      end
    else
      (1..spreadsheet.last_row).each do |i|
        cards << { sideA: spreadsheet.row(i)[0], sideB: spreadsheet.row(i)[1], proficiencyLevel: spreadsheet.row(i)[2] }
      end
    end

    cards
  end

  def self.import cards, user_id
    cards.each do |card_data|
      card = Card.new
      card.side_a = card_data["side_a"]
      card.side_b = card_data["side_b"]
      card.proficiency_level = card_data["proficiency_level"]
      card.user_id = user_id
      card.save!
    end
  end

  private

  def self.open_spreadsheet file
    case File.extname file.original_filename
    when ".csv" then Roo::CSV.new file.path
    when ".xls" then Roo::Spreadsheet.open file.path, extension: :xls
    when ".xlsx" then Roo::Spreadsheet.open file.path, extension: :xlsx
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
