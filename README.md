# Mailing

Tool for sending fast mailings

## Installation

Add this line to your application's Gemfile:

    gem 'mailing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mailing

## Usage -- the hard way

    # create channel with config
    config = {...}
    channel = Mailing::SmtpChannel.new(config)

    # create sender with channel, envelope_from and logger
    sender = Mailing::Sender.new(channel, 'sender@domain.com', Logger.new(path_to_logfile))

    # create mailing with from, subject, body, recipients
    recipients = %w(john@domain.com paul@domain.com peter@domain.com)
    mailing = Mailing::Mailing.new('from@domain.com', 'Subject', 'Body', recipients)

    # send mailing
    mailing.send(sender)

## Usage -- Rails shortcut

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
