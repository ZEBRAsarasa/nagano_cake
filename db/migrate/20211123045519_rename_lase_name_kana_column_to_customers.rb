class RenameLaseNameKanaColumnToCustomers < ActiveRecord::Migration[5.2]
  def change
    rename_column :customers, :lase_name_kana, :last_name_kana
    rename_column :customers, :is_deleyed, :is_deleted
  end
end
