class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :plaintext
      t.string :code
      t.string :title
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
