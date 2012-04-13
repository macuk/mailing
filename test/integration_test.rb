require 'minitest/autorun'
require 'mailing'
require 'stringio'
require 'logger'
require 'benchmark'

class IntegrationTest < MiniTest::Unit::TestCase
  def test_1
    # create channel
    config = {
      :address => 'localhost',
      :port    => 25,
      :domain  => 'localhost.localdomain'
    }
    channel = Mailing::SmtpChannel.new(config)

    # create sender with channel, envelope_from and logger
    log = StringIO.new
    logger = Logger.new(log)
    sender = Mailing::Sender.new(channel, 'sender@domain.com', logger)
    sender.delay = 0.1 # ~ 600 mails per minute

    # create mailing with from, subject, body, recipients
    mailing = Mailing::Mailing.new('from@domain.com', 'Subject', 'Body')
    mailing.recipients = %w(john@domain.com paul@domain.com peter@domain.com)

    # send mailing
    t = Benchmark.realtime { mailing.send(sender) }
    assert t > 0.3
    assert t < 0.4

    slog = log.string
    assert_match /from@domain.com/, slog
    assert_match /Subject/, slog
    assert_match /Body/, slog
    mailing.recipients.each { |r| assert_match %r(r), slog }
  end

  def test_2
    mailing = Mailing::Mailing.new('from@domain.com', 'Subject', 'Body')
    mailing.recipients = %w(john@domain.com paul@domain.com peter@domain.com)
    config = {
      :address => 'localhost',
      :port    => 25,
      :domain  => 'localhost.localdomain'
    }
    # send with config and envelope_from set to sender@domain.com
    # without logging and with 0.2 delay (~ 300 mails per minute)
    t = Benchmark.realtime do
      mailing.send_by_smtp(config, 'sender@domain.com', nil, 0.2)
    end
    assert t > 0.6
    assert t < 0.7
  end
end
