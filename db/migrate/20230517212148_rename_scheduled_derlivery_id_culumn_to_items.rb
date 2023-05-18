class RenameScheduledDerliveryIdCulumnToItems < ActiveRecord::Migration[6.0]
  def change
    rename_column :items, :scheduled_derlivery_id, :scheduled_delivery_id
  end
end
