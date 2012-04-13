require 'mailing/base_channel'

module Mailing
  class FakeChannel < BaseChannel
    def deliver(mail, envelope_from, recipient)
      "Sent to #{recipient}"
    end
  end
end
