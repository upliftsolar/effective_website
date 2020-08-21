class FaqsController < ApplicationController
  include Effective::CrudController

  before_render(only: :index) do
    if current_user
      resource.response_email = current_user.email
    end
  end
  submit :increment, "SHOULD NOT BE VISIBLE"
end
