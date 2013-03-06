class Client < ActiveRecord::Base
  attr_accessible :message, :phone, :name, :voice
  validates :name, presence: true
  validates :message, presence: true
  validates :phone, phone_number: true
end
