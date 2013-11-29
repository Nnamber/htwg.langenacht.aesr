class AddAttachmentXmlfileToImports < ActiveRecord::Migration
  def self.up
    change_table :imports do |t|
      t.attachment :xmlfile
    end
  end

  def self.down
    drop_attached_file :imports, :xmlfile
  end
end
