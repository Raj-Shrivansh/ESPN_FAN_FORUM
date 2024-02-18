class Message < ApplicationRecord
    belongs_to :user
    has_many :comments
    validates :title,presence: true,length: {minimum: 30}
    validates :desc,presence: true,length: {minimum: 20}
end
