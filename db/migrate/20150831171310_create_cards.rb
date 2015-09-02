class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :user, index: true, foreign_key: true
      t.text :side_a, default: ""
      t.text :side_b, default: ""
      t.integer :proficiency_level, default: 0, limit: 1

      t.timestamps null: false
    end

    add_index :cards, :proficiency_level
  end
end
