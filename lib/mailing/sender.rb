require 'mailing/delay'

module Mailing
  class Sender
    attr_accessor :channel, :envelope_from, :logger, :delay

    def initialize(channel, envelope_from, logger=nil, delay=DELAY)
      @channel = channel
      @envelope_from = envelope_from
      @logger = logger
      @delay = delay
    end

    def send(mailing)
      @mailing = mailing
      @mail = @mailing.mail
      info "Start mailing: #{Time.now}"
      info @mail.encoded
      info "Recipients count: #{@mailing.recipients.size}"
      deliver
    end

    protected
      def deliver
        info "Start sending: #{Time.now}"
        channel.start
        @mailing.recipients.each do |recipient|
          @mail.to = recipient
          info channel.deliver(@mail.encoded, @envelope_from, recipient)
          sleep @delay
        end
        channel.finish
        info "Finish sending: #{Time.now}"
        info "---" * 20
        info "\n"
      end

      def info(msg)
        return unless @logger
        @logger.info msg
      end
  end
end
