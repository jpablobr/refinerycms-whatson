# Refinery CMS Whatson

What's on engine for [Refinery CMS](http://refinerycms.com). It supports posts, categories and comments.

This version of `refinerycms-whatson` supports Rails 3.0.x. To use Rails 2.3.x use the [refinerycms-whatson "Rails 2.3.x stable branch"](http://github.com/resolve/refinerycms-whatson/tree/rails2-stable).

Options:

* Comment moderation
* [ShareThis.com](http://sharethis.com) support on posts. Set your key in Refinery's settings area to enable this.

## Requirements

Refinery CMS version 1.0.0 or above.
Your Rails 3 application should not be called "whatson"

## Install

Open up your ``Gemfile`` and add at the bottom this line:

# You now have two options:

## Take the blue pill and stay on 1.7.x

gem 'refinerycms-whatson', '~> 1.7.0'

## Take the red pill and head up to 1.8.x
## Where the previous shared/_post.html.erb partial was moved directly into show.html.erb
## *MEANING:* If you depend on that partial, you'll have to check the changes and merge your customizations back in!

gem 'refinerycms-whatson', '~> 1.8.0'

Now, run ``bundle install``

Next, to install the whatson plugin run:

rails generate refinerycms_whatson

Finally migrate your database and you're done.

rake db:migrate
