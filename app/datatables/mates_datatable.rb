class MatesDatatable < Effective::Datatable

  datatable do

    unless attributes[:community_id]
      col :community, label: 'Community Name', search: :string
    end

    unless attributes[:user_id]
      col :user, label: 'Name', search: :string
      col 'user.email'
    end

    col :roles, search: { collection: Mate::ROLES }

    col :created_at, as: :date, label: 'Joined'

    col :invitation_accepted?, label: 'Invite Accepted?', as: :boolean
    col :invitation_sent_at, as: :date

    if attributes[:actions] == false
      # Nothing
    elsif attributes[:user_id].blank? && can?(:impersonate, User)
      actions_col do |mate|
        dropdown_link_to('Impersonate', impersonate_admin_user_path(mate.user), title: "Impersonate #{mate.user}", data: { method: :post, confirm: "Impersonate #{mate.user}?"})
      end
    else
      actions_col
    end
  end

  collection do
    scope = Mate.joins(:user).includes(:user, :community).all

    if attributes[:community_id]
      scope = scope.where(community_id: attributes[:community_id])
    end

    if attributes[:user_id]
      scope = scope.where(user_id: attributes[:user_id])
    end

    scope
  end

end
