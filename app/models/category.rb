class Category
  include Mongoid::Document
  include Mongoid::Paperclip
  
  
  field :cat, :type => String
  
  
  has_mongoid_attached_file :catbanner
  do_not_validate_attachment_file_type :catbanner
  
  belongs_to :vendor
end
