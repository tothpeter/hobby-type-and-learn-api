class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.integer :position, default: 0, limit: 3

      t.timestamps null: false
    end
  end
end
