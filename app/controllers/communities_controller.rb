# My Communities
class CommunitiesController < ApplicationController
  before_action :authenticate_user!

  include Effective::CrudController

  resource_scope -> { Community.deep.for_user(current_user) }

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

end
