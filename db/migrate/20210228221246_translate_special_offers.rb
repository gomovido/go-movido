class TranslateSpecialOffers < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        SpecialOffer.create_translation_table!({
          name: :string
        }, {
          migrate_data: true,
          remove_source_columns: true
        })
      end

      dir.down do
        SpecialOffer.drop_translation_table! migrate_data: true
      end
    end
  end
end
