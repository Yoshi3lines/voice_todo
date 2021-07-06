class List < ApplicationRecord
  belongs_to :user
  has_many :cards, -> { order(position: :asc) }, dependent: :destroy

  validates :title, length: { in: 1..255 }

  mount_uploader :audio, AudioUploader
end
