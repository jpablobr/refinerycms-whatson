module Whatson
  class CommentMailer < ActionMailer::Base

    def notification(comment, request)
      subject     WhatsonComment::Notification.subject
      recipients  WhatsonComment::Notification.recipients
      from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
      sent_on     Time.now
      @comment =  comment
    end

  end
end