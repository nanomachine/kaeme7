class CreateReportTypes < ActiveRecord::Migration
  def change
    create_table :report_types do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
