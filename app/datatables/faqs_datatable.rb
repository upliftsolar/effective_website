class FaqsDatatable < Effective::Datatable

  bulk_actions do
    bulk_action 'Delete selected', faq_path(:ids), data: { method: :delete, confirm: 'Really delete selected?' }
  end

  reorder :position

  datatable do
    order :updated_at

    bulk_actions_col

    col :updated_at, visible: false
    col :created_at, visible: false
    col :id, visible: false

    col :question do |f|
      #TODO: 
      #"<p><strong>#{f.question}</strong>#{f.answer}</p>".html_safe
    end
    col :answer
    col :archived, search: { value: false }

    actions_col
  end

  collection do
    Faq.deep.all
  end

end
