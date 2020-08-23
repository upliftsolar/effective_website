class QuestionsDatatable < Effective::Datatable
  ANSWER_LENGTH = 200 #characters

  datatable do
    order :position

    col :updated_at, visible: false
    col :created_at, visible: false
    col :id, visible: false
    col :position, visible: false

    col :question, label: t("Search") do |f|
      #TODO: hide most of long responses... unless featured == true. 
      if f.answer && (f.featured || (f.answer.length < ANSWER_LENGTH+20)) #OR the response was short to begin with
        "<p><strong>#{sanitize f.question}</strong>&nbsp;&nbsp;&nbsp;&nbsp;<p>#{f.answer}</p></p>".html_safe
      elsif f.answer
        binding.pry
        "<p><strong>#{sanitize f.question}</strong>&nbsp;&nbsp;&nbsp;&nbsp;<p>#{f.answer[0..ANSWER_LENGTH]}#{link_to "See Full Answer", "javascript:showThisAnswer(this);"}</p></p>".html_safe
      else
        "<p><strong>#{sanitize f.question}</strong>&nbsp;&nbsp;&nbsp;&nbsp;<p>#{t(:question_not_yet_answered)}</p></p>".html_safe
      end
    end
    col :archived, search: { value: false }, visible: false
  end

  collection do
    ar = Question.answered.or(Question.unanswered.mine(current_user))
    ar.where(locale: Thread.current[:locale])
  end

end
