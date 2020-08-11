EffectiveRoles.setup do |config|
  # So this is a bit weird because of the flat array
  # The :admin, :staff, :community and :reserved are for USERS
  # the owner, member, collaborator are for MATES
  # Sorry.

  config.roles = [:admin, :staff, :community, :reserved, :owner, :member, :collaborator] # Only add to the end of this array.  Never prepend roles.

  # config.role_descriptions
  # ========================
  # This setting configures the text that is displayed by form helpers (see README.md)

  config.role_descriptions = {
    # User roles
    :admin => 'can log in to the /admin section of the website. full access to everything.',
    :staff => 'can log in to the /admin section of the website.',
    :community => 'can log in to the /community section of the website.',

    # Mate roles
    :owner => 'can manage community settings and orders',
    :member => 'can create, update and destroy community resources',
    :collaborator => 'can view community resources'
  }

  # config.assignable_roles
  # Which roles can be assigned by whom
  # =======================
  # When current_user is passed into a form helper function (see README.md)
  # this setting determines which roles that current_user may assign

  config.assignable_roles = {
    # User roles
    admin: [:admin, :staff, :community, :owner, :member, :collaborator],
    staff: [:staff, :community, :owner, :member, :collaborator],
    community: [:member, :collaborator],

    # Mate roles
    owner: [:member, :collaborator],
    member: [:member, :collaborator],
    collaborator: []
  }

  # config.authorization_method_for_summary_table
  # This has absolutely no affect on the any logic involving roles
  # It's purely for the effective_roles_summary_table() helper method
  #
  # It should match the authorization check used by your application
  #
  # Use CanCan: can?(action, resource)
  config.authorization_method = Proc.new { |controller, action, resource| authorize!(action, resource) }

  # Layout Settings
  # Configure the Layout per controller, or all at once
  config.layout = 'admin'
end
