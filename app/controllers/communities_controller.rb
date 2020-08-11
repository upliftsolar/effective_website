# My Communities
class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:list]

  include Effective::CrudController
  skip_authorization_check only: [:list]
  
  resource_scope -> { Community.deep }

  before_action(only: :index) do
    communities_length = resource_scope.to_a.length

    if communities_length == 0
      flash[:danger] = 'Your website account does not belong to any community groups. Please contact the webmaster for assistance.'
      redirect_to root_path
    end

    if communities_length == 1
      redirect_to community_path(resource_scope.first)
    end
  end

  def list
    @datatable = CommunitiesDatatable.new
    #render :index
  end

end
