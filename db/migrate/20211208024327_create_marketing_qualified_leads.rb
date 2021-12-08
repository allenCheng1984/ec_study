class CreateMarketingQualifiedLeads < ActiveRecord::Migration[6.1]
  def change
    create_table :marketing_qualified_leads do |t|
      t.string :mql_id
      t.date :first_contact_date
      t.string :landing_page_id
      t.string :origin

      t.timestamps
    end
  end
end
