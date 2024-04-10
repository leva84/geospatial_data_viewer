class CreateExcavators < ActiveRecord::Migration[7.1]
  def change
    create_table :excavators do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :company_name
      t.string :address
      t.boolean :crew_on_site

      t.timestamps
    end
  end
end
