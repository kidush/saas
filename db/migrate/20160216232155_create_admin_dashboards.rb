class CreateAdminDashboards < ActiveRecord::Migration
  def change
    create_table :admin_dashboards do |t|

      t.timestamps null: false
    end
  end
end
