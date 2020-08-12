# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

puts '== Creating users ======================'

# The webmaster and/or super priviledged staff member. Can do anything.
admin = User.create!(email: 'darius.roberts@gmail.com', first_name: 'Darius', last_name: 'Roberts', roles: :admin, password: 'example')

# Can access /admin and administer the site.
staff = User.create!(email: 'staff@codeandeffect.com', first_name: 'Staff', last_name: 'User', roles: :staff, password: 'example')

puts '== Creating communities ===================='
# Can access /communities and belong to community groups.
3.times do
  community = Community.new(name: Faker::Company.name)

  [:owner, :member, :collaborator].each do |role|
    user = User.create!(
      email: "#{role}@#{community.name.parameterize}.com",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      roles: :community,
      password: 'be_effective'
    )

    community.mates.build(user: user, roles: role)
  end

  community.save!
end

puts '== Creating pages ======================'

# Some Pages
Effective::Page.new(
  title: 'About',
  meta_description: 'About the example website',
  layout: 'application',
  template: 'page'
).save!

Effective::Page.new(
  title: 'Contact',
  meta_description: 'Contact us at the example website',
  layout: 'application',
  template: 'page'
).save!

Effective::Page.new(
  title: 'Communities',
  meta_description: 'A example community-only page',
  layout: 'application',
  template: 'page',
  roles: [:community]  # Only communities can see this page.
).save!

=begin
rails g effective:scaffold ServiceProvider name:string address:string locality:string email:string phone:string phone:string title:string verifications:text flagged_text:text

1. Name
2. Address
3. Region worked (city or county)
4. email
5. telephone number
6. Professional Title ("electrical engineer" or "perito electricista" ) and yes, the pages need to be bi-lingual
7. Certification or Member in Good Standing of the following:


=end

puts '== Creating posts ====================='

# Some Posts
post = Effective::Post.new(
  title: 'An example first post',
  excerpt: '<p>This is the most effective first post on the internet.</p>',
  description: 'An effective first post',
  body: 'An example first post.',
  category: EffectivePosts.categories.first.presence || 'posts',
  published_at: Time.zone.now
).save!

puts '== All Done, have a great day =========='
puts 'Visit http://localhost:3000 and Sign In as: admin@codeandeffect.com with any password'
