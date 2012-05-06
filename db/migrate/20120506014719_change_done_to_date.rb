class ChangeDoneToDate < ActiveRecord::Migration
  def self.up
    add_column :countries, :date_started, :date
    remove_column :countries, :done
  end

  def self.down
    add_column :countries, :done, :boolean
    remove_column :countries, :date_started
  end
end
