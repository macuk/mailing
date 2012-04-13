module Mailing
  class BaseChannel

    attr_accessor :config

    def initialize(config)
      @config = config
    end

    def start
    end

    def deliver(mail, envelope_from, recipient)
    end

    def finish
    end
  end
end
