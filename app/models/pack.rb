class Pack < ApplicationRecord
  has_many :categories, dependent: :destroy
  has_many :services, through: :categories, dependent: :destroy
  validates :name, presence: true
  validates :name, inclusion: { in: ['settle_in', 'starter'] }
  validates :name, uniqueness: { case_sensitive: false }

  def starter?
    name == 'starter'
  end

end
