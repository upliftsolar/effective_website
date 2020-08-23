class Admin::QuestionsDatatable < Effective::Datatable

  bulk_actions do
    #bulk_action 'Delete selected', question_path(:ids), data: { method: :delete, confirm: 'Really delete selected?' }
    #bulk_action 'Archive selected', question_path(:ids), data: { method: :delete, confirm: 'Really delete selected?' }
  end


  datatable do
    reorder :position

    bulk_actions_col

    col :updated_at, visible: false
    col :created_at, visible: false
    col :id, visible: false

    col :question do |f|
      f.question #+ link_to("[Edit]",[:admin,f,:edit])
    end
    col :answer
    col :archived, search: { value: false }

    actions_col
  end

  collection do
    Question.deep.all
  end

end
