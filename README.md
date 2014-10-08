# ActsAsAuditable

* [![Build Status](https://secure.travis-ci.org/continuum/espinita.png)](http://travis-ci.org/continuum/espinita)
* [![Dependency Status](https://gemnasium.com/jbox-web/acts_as_auditable.svg)](https://gemnasium.com/jbox-web/acts_as_auditable)
* [![Coverage Status](https://coveralls.io/repos/continuum/espinita/badge.png?branch=master)](https://coveralls.io/r/continuum/espinita?branch=master)
* [![Code Climate](https://codeclimate.com/github/jbox-web/acts_as_auditable/badges/gpa.svg)](https://codeclimate.com/github/jbox-web/acts_as_auditable)

## Audits ActiveRecord models

This project is a merge of [audited gem](https://github.com/collectiveidea/audited) and [espinita gem](https://github.com/continuum/espinita).

Explanation :

If found that the Espinita implementation as a Rails engine was a good idea and cleaner than the Sweeper objects of Audited. But it misses the ```has_associated_audits``` method from Audited gem.
On the top of that, the scope name wasn't very meaningfull, so I renamed it to ActsAsAuditable.
Thus this new gem.


## Installation

In your gemfile

```ruby
gem "acts_as_auditable"
```

In console
```ruby
$ rake acts_as_auditable:install:migrations
$ rake db:migrate
```

## Usage

```ruby
class Post < ActiveRecord::Base
  auditable
end

@post.create(title: "an awesome blog post" )
```

ActsAsAuditable will create an audit by default on creation, edition and destroy:

```ruby
@post.audits.size #=> 1
```

ActsAsAuditable provides options to include or exclude columns to trigger the creation of audit.

```ruby
class Post < ActiveRecord::Base
  auditable only: [:title] # except: [:some_column]
end
```

And lets you declare the callbacks you want for audit creation:

```ruby
class Post < ActiveRecord::Base
  auditable on: [:create]  # on: [:create, :update]
end
```

You can find the audits records easily:

```ruby
@post.audits.first #=>  #<ActsAsAuditable::Audit id: 1, auditable_id: 1, auditable_type: "Post", user_id: 1, user_type: "User", audited_changes: {"title"=>[nil, "MyString"], "created_at"=>[nil, 2013-10-30 15:50:14 UTC], "updated_at"=>[nil, 2013-10-30 15:50:14 UTC], "id"=>[nil, 1]}
```

ActsAsAuditable will save the model changes in a serialized column called audited_changes:

```ruby
@post.audits.first.audited_changes #=> {"title"=>[nil, "MyString"], "created_at"=>[nil, 2013-10-30 15:50:14 UTC], "updated_at"=>[nil, 2013-10-30 15:50:14 UTC], "id"=>[nil, 1]}
```

ActsAsAuditable will detect the current user when records saved from rails controllers. By default ActsAsAuditable uses current_user method but you can change it:

```ruby
ActsAsAuditable.current_user_method = :authenticated_user
```
