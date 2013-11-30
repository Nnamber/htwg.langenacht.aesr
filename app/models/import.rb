class Import < ActiveRecord::Base
  
  has_attached_file :xmlfile
  # before_save :import_file TODO: als Alternative zum manuellen Import?
  validates :xmlfile, presence:true
  # TODO validation of filetype
end
