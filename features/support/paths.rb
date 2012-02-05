module NavigationHelpers
  module Refinery
    module Whatson
      def path_to(page_name)
        case page_name
        when /the list of whatson posts/
          admin_whatson_posts_path
        when /the new whatson posts? form/
          new_admin_whatson_post_path
        else
          begin
            if page_name =~ /the whatson post titled "?([^\"]*)"?/ and (page = WhatsonPost.find_by_title($1)).present?
              self.url_for(page.url)
            else
              nil
            end
          rescue
            nil
          end
        end
      end
    end
  end
end
