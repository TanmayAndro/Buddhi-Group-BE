class RenamePollingIdToOldPollingIdInNewVotes < ActiveRecord::Migration[7.1]
  def change
    rename_column :new_votes, :polling_id, :old_polling_id
  end
end
