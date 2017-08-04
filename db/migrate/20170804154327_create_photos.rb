class CreatePhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :body
      t.integer :visit_count, default: 0

      t.timestamps
    end
  end
end
