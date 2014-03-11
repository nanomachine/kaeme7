class AddAttachmentAvatarToReportTypes < ActiveRecord::Migration
  def self.up
    change_table :report_types do |t|
      t.has_attached_file :avatar
    end
  end

  def self.down
    drop_attached_file :report_types, :avatar
  end
end