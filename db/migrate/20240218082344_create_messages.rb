class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :desc

      t.timestamps
    end
  end
end
