class User < ApplicationRecord
  before_save { |user| user.name = user.name.titleize }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :entries, dependent: :destroy
  has_many :journals, dependent: :destroy
  
  validates :name, presence: true
end
