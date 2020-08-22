class Ability
  include CanCan::Ability

  def initialize(user)
    can [:index,:increment,:create], Faq
    can :index, FaqsDatatable

    can [:new,:create], Lead
    can :manage, ServiceProvider
    cannot :access, :admin

    user ||= User.new

    # Account / Shared abilities
    can [:edit, :update], User, id: user.id

    # Effective Gems
    can [:index, :show], Effective::Post
    can [:index, :show], Effective::StyleGuide

    can [:index, :show, :list], Community
    can :index, Effective::Page
    can(:show, Effective::Page) { |page| page.roles_permit?(user) }

    if user.is?(:community)
      community_abilities(user)
    end

    if user.is?(:staff)
      staff_abilities(user)
    end

    if user.is?(:admin)
      staff_abilities(user)
      admin_abilities(user)
    end
  end

  private

  def community_abilities(user)
    can :manage, Effective::Cart, user_id: user.id
    can :manage, Effective::Order, user_id: user.id # Orders cannot be deleted

    # My Communitys
    can [:index, :show, :edit], Community, id: user.community_ids
    can :update, Community, id: user.community_ids(:owner)
    can [:destroy, :transfer], Community, id: user.community_ids(:owner)

    # My Mates
    can([:new, :create], Mate) { |mate| user.community_ids(:owner, :member).include?(mate.community_id) }
    can(:index, Mate) { |mate| user.community_ids(:owner, :member).include?(mate.community_id) }
    can(:show, Mate) { |mate| user.community_ids(:owner, :member).include?(mate.community_id) || mate.user_id == user.id }
    can(:destroy, Mate) { |mate| user.community_ids(:owner).include?(mate.community_id) || (!mate.is?(:owner) && mate.user_id == user.id) }
    can(:promote, Mate) { |mate| user.community_ids(:owner).include?(mate.community_id) && !mate.is?(:owner) && mate.user_id != user.id }
    can(:demote, Mate) { |mate| user.community_ids(:owner).include?(mate.community_id) && !mate.is?(:collaborator) && mate.user_id != user.id }
    can(:reinvite, Mate) { |mate| user.community_ids(:owner, :member).include?(mate.community_id) && !mate.invitation_accepted? }
  end

  def staff_abilities(user)
    can :access, :admin
    can :admin, Faq
    can :index, Admin::FaqsDatatable

    #TODO: make an admin controller
    can :manage, Lead

    # Effective Gems
    can [:new, :create, :edit, :update, :destroy], Effective::Page
    can :manage, Effective::Menu
    can :manage, Effective::CkAsset
    can :manage, Effective::Log
    can :manage, Effective::Post
    can :manage, Effective::Region

    can :manage, Effective::Order
    can :show, :payment_details # Can see the payment purchase details on orders

    can :admin, :effective_logging
    can :admin, :effective_orders
    can :admin, :effective_pages
    can :admin, :effective_posts
    can :admin, :effective_roles

    # Communitys
    can(crud, Community)
    acts_as_archived(Community)
    can(:transfer, Community) { |community| user.community_ids(:owner).include?(community.id) }

    # Mates
    can(crud, Mate)
    can(:promote, Mate) { |mate| !mate.is?(:owner) }
    can(:demote, Mate) { |mate| !mate.is?(:collaborator) }
    can(:reinvite, Mate) { |mate| !mate.invitation_accepted? }

    # Users
    can(crud, User)
    acts_as_archived(User)
    can(:impersonate, User) { |user| user.is?(:community) }
    can(:invite, User) { |user| user.new_record? }
    can(:reinvite, User) { |user| !user.invitation_accepted? || user.invitation_sent_at.blank? }
  end

  def admin_abilities(user)
    can(:impersonate, User) { |user| user.is?(:community) || user.is?(:staff) }
  end

end
