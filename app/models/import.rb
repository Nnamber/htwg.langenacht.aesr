class Import < ActiveRecord::Base
  
  has_attached_file :xmlfile
  validates :xmlfile, presence:true
  # TODO validation of filetype
end
