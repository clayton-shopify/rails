require 'active_job'

module ActionMailer
  # The ActionMailer::DeliveryJob class is used when you
  # want to send emails outside of the request-response cycle.
  class DeliveryJob < ActiveJob::Base # :nodoc:
    queue_as { ActionMailer::Base.deliver_later_queue_name }

    def perform(mailer, mail_method, delivery_method, locale, *args) #:nodoc:
      I18n.with_locale(locale) do
        mailer.constantize.public_send(mail_method, *args).send(delivery_method)
      end
    end
  end
end
