class Admin::UsersDatatable < Effective::Datatable

  filters do
    scope :unarchived, label: 'All'
    scope :admins
    scope :staff
    scope :communities
    scope :archived
  end

  datatable do
    order :updated_at, :desc

    col :id, visible: false
    col :updated_at, label: 'Updated', visible: false
    col :created_at, label: 'Created', visible: false

    col :email
    col :first_name
    col :last_name
    col :roles, search: User::ROLES

    col :communities do |user|
      user.communities.map do |community|
        mate = user.mates.find { |mate| mate.community_id == community.id }

        title = (can?(:edit, community) ? link_to(community, edit_admin_community_path(community), title: community.to_s) : community.to_s)
        badge = content_tag(:span, mate.roles.join, class: 'badge badge-info')

        content_tag(:div, (title + ' ' + badge), class: 'col-resource-item')
      end.join
    end

    col :invitation_accepted?, label: 'Invite Accepted?', as: :boolean
    col :invitation_sent_at, as: :date

    col :sign_in_count, visible: false

    col :last_sign_in_at, visible: false do |user|
      (user.current_sign_in_at.presence || user.last_sign_in_at).try(:strftime, '%F %H:%M')
    end

    actions_col
  end

  collection do
    User.deep.all
  end

end
