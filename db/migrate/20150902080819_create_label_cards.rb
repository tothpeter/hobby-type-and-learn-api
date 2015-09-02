class CreateLabelCards < ActiveRecord::Migration
  def change
    create_table :labels_cards do |t|
      t.references :label, index: true, foreign_key: true
      t.references :card, index: true, foreign_key: true

      # t.timestamps null: false
    end

    add_index :labels_cards, [ :label_id, :card_id ], :unique => true, :name => 'by_label_and_card'
  end
end
