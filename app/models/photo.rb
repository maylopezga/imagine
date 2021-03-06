class Photo < ApplicationRecord

  belongs_to :user

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true, length: {minimum:10}
  before_create :set_visits_count

  enum status: [:publico, :privado, :compartido]

  has_attached_file :cover, styles: {medium: "800x600", thu:"100x50"}
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

  def update_visits_count
    #self.save if self.visit_count.nil?
    self.update(visit_count: self.visit_count + 1)
  end

  private
  def set_visits_count
    self.visit_count ||=0
  end
end
