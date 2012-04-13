module Mailing
  class Mailing
    require 'mail'

    attr_accessor :from, :subject, :body, :recipients

    def initialize(from, subject, body, recipients=[])
      @from, @subject, @body = from, subject, body
      @recipients = recipients
    end

    def send(sender)
      sender.send(self)
    end

    def send_by_smtp(config, envelope_from, logger=nil, delay=DELAY)
      channel = SmtpChannel.new(config)
      sender = Sender.new(channel, envelope_from, logger, delay)
      send(sender)
    end

    def mail(builder=Mail)
      mail = builder.new(:from => @from, :subject => @subject, :body => @body)
      mail.charset = 'UTF-8'
      mail.content_transfer_encoding = "8bit"
      mail
    end
  end
end
