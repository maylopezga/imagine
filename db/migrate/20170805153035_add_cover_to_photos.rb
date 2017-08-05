class AddCoverToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_attachment :photos,:cover
  end
end
