require 'mailing/base_channel'

module Mailing
  class SmtpChannel < BaseChannel
    require 'net/smtp'

    # config: hash with smtp configuration
    # {
    #   :address              => "host.domain.com",
    #   :port                 => 25,
    #   :domain               => 'domain.com',
    #   :user_name            => 'user@domain.com',
    #   :password             => 'password',
    #   :authentication       => :login,
    #   :enable_starttls_auto => true,
    #   :openssl_verify_mode  => 'none'
    # }
    def initialize(config)
      super
      @smtp = nil
    end

    def start
      @smtp = Net::SMTP.new(@config[:address], @config[:port])
      @smtp.enable_starttls_auto if @config[:enable_starttls_auto]
      @smtp.start(@config[:domain], @config[:user_name],
                 @config[:password], @config[:authentication])
    end

    def deliver(mail, envelope_from, recipient)
      begin
        @smtp.sendmail(mail, envelope_from, recipient)
        "Sent to #{recipient}"
      rescue Exception => e
        finish
        start
        "Error for #{recipient}: #{e}".strip
      end
    end

    def finish
      @smtp.finish
    end
  end
end
