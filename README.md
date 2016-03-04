# Simple message-wall application.
---
## (Rails, jQuery, Bootstrap, coffee/slim)

- Authorization with 'devise' and related omniauth gems.

- Implemented omniauth feature for:

  - Twitter,
  - Google+,
  - Facebook,
  - Vkontakte.

- Posts on homepage sorted by the date added (DESC), comments sorted in ASC order.

- Tree-like structure implemented using 'closure_tree' gem.

- Infinite scrolling implemented via 'will_paginate' gem and ajax requests.

- To seed database with faked data used 'faker', 'factory_girl' gems. To populate DB run:

        `rake db:seed`

- RSpec for unit tests. (not fully covered)

- Integration tests are not yet implemented.
