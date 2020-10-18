class LeadsDatatable < Effective::Datatable

  bulk_actions do
    bulk_action 'Delete selected', lead_path(:ids), data: { method: :delete, confirm: 'Really delete selected?' }
  end

  datatable do
    order :updated_at

    bulk_actions_col

    col :updated_at, visible: false
    col :created_at, visible: false
    col :id, visible: false

    col :full_name
    col :purpose
    col :body do |l|
      l.body.to_s[0...50]
    end
    col :locality

    actions_col
  end

  collection do
    Lead.deep.all
  end

end
