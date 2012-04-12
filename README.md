# Mailing

Tool for sending fast mailings

## Installation

Add this line to your application's Gemfile:

    gem 'mailing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailing

## Step by step usage

    require 'mailing'
    require 'logger'

    # create channel
    config = {
      :address => 'localhost',
      :port    => 25,
      :domain  => 'localhost.localdomain'
    }
    channel = Mailing::SmtpChannel.new(config)

    # create sender with channel, envelope_from and logger
    logger = Logger.new('/tmp/mailing.log')
    sender = Mailing::Sender.new(channel, 'sender@domain.com', logger)

    # create mailing with from, subject, body, recipients
    mailing = Mailing::Mailing.new('from@domain.com', 'Subject', 'Body')
    mailing.recipients = %w(john@domain.com paul@domain.com peter@domain.com)

    # send mailing
    mailing.send(sender)

## Quick usage

    require 'mailing'
    require 'logger'

    mailing = Mailing::Mailing.new('from@domain.com', 'Subject', 'Body')
    mailing.recipients = %w(john@domain.com paul@domain.com peter@domain.com)
    config = {
      :address => 'localhost',
      :port    => 25,
      :domain  => 'localhost.localdomain'
    }
    mailing.send_by_smtp(config, 'sender@domain.com')

## Rails usage

    mailing = Mailing::Mailing.new('from@domain.com', 'Subject', 'Body')
    mailing.recipients = User.pluck(:email)
    mailing.send_by_smtp(ActionMailer::Base.smtp_settings,
                         'sender@domain.com', Rails.logger)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
