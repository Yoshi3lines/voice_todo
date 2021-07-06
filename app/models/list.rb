class List < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  # has_many :cards, -> { order(position: :asc) }

  validates :title, length: { in: 1..255 }

  mount_uploader :audio, AudioUploader
end
