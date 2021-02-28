class TranslateProductFeatures < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        ProductFeature.create_translation_table!({
          name: :string,
          description: :string
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        ProductFeature.drop_translation_table! migrate_data: true
      end
    end
  end
end
