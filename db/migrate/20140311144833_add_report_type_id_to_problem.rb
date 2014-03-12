class AddReportTypeIdToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :report_type_id, :int
  end
end
