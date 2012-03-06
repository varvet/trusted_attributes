# Trusted Attributes

This module adds the `attributes` method to controllers which makes it possible
to do mass assignment, while making sure that only trusted attributes are
updated. In effect it moves mass assignment protection to the controller.

Add the gem to your Gemfile:

``` ruby
gem "trusted_attributes"
```

Include it in your application controller:

``` ruby
class ApplicationController < ActionController::Base
  include TrustedAttributes
end
```

Whenever you would normally assign a hash from params, use `attributes`
instead.  For example:

``` ruby
def create
  @realm = Realm.new(attributes)
  if @realm.save
    redirect_to @realm
  else
    render :new
  end
end
```

To mark attributes as trusted, you can use the `trust` class method:

``` ruby
class RealmsController < ApplicationController
  trust :name, :max_data, :max_time

  def create
    @realm = Realm.new(attributes)
    ...
  end
end
```

You can also use the instance method `trust`, for example if different users
have access to different attributes:

``` ruby
class RealmsController < ApplicationController
  trust :name, :max_data, :max_time

  def create
    trust :global if current_user.admin?
    @realm = Realm.new(attributes)
    ...
  end
end
```

When not running in production mode, an error will be raised when non trusted
attributes are sent, in production mode, the non trusted attributes are
silently ignored.

## License

(The MIT License)

Copyright (c) 2012 Ivan Navarrete and Jonas Nicklas

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
Vimium has been updated to 1.32.x
