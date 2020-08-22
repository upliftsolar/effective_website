class FaqsDatatable < Effective::Datatable

  datatable do
    order :position

    col :updated_at, visible: false
    col :created_at, visible: false
    col :id, visible: false
    col :position, visible: false

    col :question, label: "Search" do |f|
      #TODO: 
      "<p><strong>#{f.question}</strong>#{f.answer}</p>".html_safe
    end
    col :archived, search: { value: false }, visible: false
  end

  collection do
    Faq.answered + Faq.unanswered.mine
  end

end
