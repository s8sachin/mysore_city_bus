class CreateBusRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :bus_routes do |t|
      t.string :bus_num
      t.string :route, array: true, default: []

      t.timestamps
    end
  end
end
