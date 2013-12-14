class Import < ActiveRecord::Base

  has_attached_file :xmlfile
  validates :xmlfile, presence:true
  # TODO validation of filetype

  # TODO: als Alternative zum manuellen Import?
  #after_save :dostuff 
  #self.import_file
  
  #def dostuff
  #  puts "dumme sau"
   # ImportsController.import_file
  #end
end
