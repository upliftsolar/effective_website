# Effective Website

This is a rails starter website that uses most of the effective_* gems.

Ruby 2.6.3, Rails 6.0.3

## Live Demo

Click here for a [Live Demo](https://effective-website-demo.herokuapp.com/).

Login as `admin@codeandeffect.com` with password `example`.

## Getting Started

```ruby
git clone git@github.com:code-and-effect/effective_website.git
cd effective_website
cp .env.example .env  # Fixes SECRET_KEY_BASE errors
bundle
rails db:create db:migrate db:seed
rails server
```

Login as `admin@codeandeffect.com` with any password.

- Search the entire project for 'example' and fill in your site specifics.
- Good luck!

## Page Order in Navbar

Because the "menu" features are not currently active in Effective::Pages, a poor-man's navigation system exists, using a single method in ApplicationHelper. YMMV.

## Translation Features

Different features require different types of Translation functionality.

- Translation within the editable regions (use the <pre>ES:[[...]]</pre> style )
- Translation of site text and interactive "flash" messages: use /tolk to
- FAQ (Questions) Snippets are locale-specific.

## Tests

Run tests with

```ruby
rails test
rails test:system

rails test:bot:environment
rails test:bot:system
```

## Docker

You can also use Docker to install and run this site:

```
cp config/database.yml.docker config/database.yml
docker-compose build

# One time
docker-compose run web bash
rake db:create db:migrate db:seed
exit

# And then, each time
docker-compose run web
```

## Elastic Beanstalk & ROR

Alternatively you can deploy the app using AWS Elastic Beanstalk.

### Elastic Beanstalk (eb) CLI

[Read](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install-advanced.html) and follow instructions to install on Windows, Linux or MacOS.

### Configuration and Deployments

```bash
cd effective_website
eb init
# It appears you are using Docker. Is this correct? => n
# Select a platform. => 11) Ruby
# Select a platform branch. => 1) Ruby 2.7 running on 64bit Amazon Linux 2
# Do you wish to continue with CodeCommit? (y/N) (default is n): => n
# Do you want to set up SSH for your instances? =>y

eb create effective-website-dev -db.engine postgres -db.user postgres -db.pass password1234
eb setenv SECRET_KEY_BASE=$(rails secret) REDIS_URL=redis://localhost:6379
eb deploy effective-website-dev
```

Also, if not using master-key credentials, please setenv any relevant AWS variables (see S3, below)

To effect code changes, commit your code then eb deploy.

## Create/Configure an S3 Bucket

You will need an AWS IAM user with sufficient priviledges and a properly configured S3 bucket to use with effective_assets

### Log into AWS Console

- Visit http://aws.amazon.com/console/
- Click 'Sign In to the Console' from the top-right and sign in with your AWS account.

### Create an S3 Bucket

- Click Services -> S3 from the top-left menu
- Click Create Bucket
- Give the Bucket a name, and select the US East (N. Virgina) region.
- Click Next, Next, Next
- Don't configure permissions yet, we still have to create a user
- Click Next

### Configure CORS Permissions

- From the S3 All Buckets Screen (as above)

- Click the S3 bucket we just created
- Click the Permissions tab
- Click CORS configuration and enter the following:

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>Authorization</AllowedHeader>
</CORSRule>
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedHeader>*</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```

- Click Save

The Bucket is now set up and ready to accept uploads, but we still need a user that has permission to access S3

### Create an IAM User and record its AWS Access Keys

- After logging in to your AWS console

- Click Services -> IAM from the top-left

- Select Users from the left-side menu
- Click Add user
- Give it a user name
- Check Yes Programmatic access, No AWS management console access

- Click Next: Permissions
- Click Create group
- Give it a name like 's3-full-access'
- Sroll down and select 'AmazonS3FullAccess'
- Click Create group
- Click Next: Review
- Click Create user
- Record the Access key ID and Secret access key.

Copy these values into your `.env` file.

This user is now set up and ready to access the S3 Bucket previously created.

## License

MIT License. Copyright [Code and Effect Inc.](https://www.codeandeffect.com/)

## Testing

```ruby
rails test
rails test:system
rails test:bot:environment
rails test:bot

rails test:system TOUR=true
rails test:bot TEST=admin/clients#index
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Bonus points for test coverage
6. Create new Pull Request

