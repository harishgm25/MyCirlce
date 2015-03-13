class Vendor
  include Mongoid::Document
  include Mongoid::Paperclip

  field :name, :type => String
  field :address, :type => String
  field :long, :type => String
  field :lati, :type => String

  has_mongoid_attached_file :banner
  do_not_validate_attachment_file_type :banner
  
  has_many :categories, autosave: true
  accepts_nested_attributes_for :categories, :allow_destroy => true, :reject_if => lambda{ |a| a.any? {|k,v| v.blank?} } 

 
end
