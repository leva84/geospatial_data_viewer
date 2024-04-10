class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'postgis'

    create_table :tickets do |t|
      t.string :request_number
      t.string :sequence_number
      t.string :request_type
      t.string :request_action
      t.datetime :response_due_date_time
      t.string :primary_service_area_code
      t.string :additional_service_area_codes, array: true, default: []
      t.st_polygon :well_known_text, geographic: true, srid: 4326

      t.timestamps
    end
  end
end
