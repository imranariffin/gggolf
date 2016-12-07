class ContactPlayer < ApplicationRecord
    
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :content


  validates :content,
    presence:{message:'Content cannot be empty'}

end
