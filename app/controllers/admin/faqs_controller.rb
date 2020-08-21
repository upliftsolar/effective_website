class Admin::FaqsController < ApplicationController
  include Effective::CrudController
  submit :increment, "SHOULD NOT BE VISIBLE"
end
