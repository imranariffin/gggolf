class Contactform < ApplicationRecord
    
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :content

  validates :name,
    presence:  {message:'Name cannot be empty'}

  validates :email,
    presence:  {message:'Email cannot be empty'}


  validates :content,
    presence:  {message:'Content cannot be empty'}

    
end
