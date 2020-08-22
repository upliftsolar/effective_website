class Admin::FaqsDatatable < Effective::Datatable

  bulk_actions do
    #bulk_action 'Delete selected', faq_path(:ids), data: { method: :delete, confirm: 'Really delete selected?' }
    #bulk_action 'Increment selected', faq_path(:ids), data: { method: :delete, confirm: 'Really delete selected?' }
  end


  datatable do
    reorder :position

    bulk_actions_col

    col :updated_at, visible: false
    col :created_at, visible: false
    col :id, visible: false

    col :question
    col :answer
    col :archived, search: { value: false }

    actions_col
  end

  collection do
    Faq.all
  end

end
