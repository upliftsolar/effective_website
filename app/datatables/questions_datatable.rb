class QuestionsDatatable < Effective::Datatable

  datatable do
    order :position

    col :updated_at, visible: false
    col :created_at, visible: false
    col :id, visible: false
    col :position, visible: false

    col :question, label: t("Search") do |f|
      #TODO: 
      "<p><strong>#{f.question}</strong>&nbsp;&nbsp;&nbsp;&nbsp;#{f.answer}</p>".html_safe
    end
    col :archived, search: { value: false }, visible: false
  end

  collection do
    ar = Question.answered.or(Question.unanswered.mine)
    ar.where(locale: Thread.current[:locale])
  end

end
