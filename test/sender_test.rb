require 'minitest/autorun'
require 'mailing/sender'

class SenderTest < MiniTest::Unit::TestCase
  def setup
    @channel = MiniTest::Mock.new
    @channel.expect(:start, nil)
    @channel.expect(:deliver, 'delivered', [String, String, String])
    @channel.expect(:finish, nil)

    @sender = Mailing::Sender.new(@channel, 'me@host.com')

    @mail = MiniTest::Mock.new
    @mail.expect(:encoded, 'mail')
    @mailing = MiniTest::Mock.new
    @mailing.expect(:mail, @mail)
  end

  def test_init
    assert_equal 'me@host.com', @sender.envelope_from
    assert_nil @sender.logger
    assert_equal 0.5, @sender.delay
  end

  def test_accessors
    @sender.envelope_from = 'test@test.com'
    assert_equal 'test@test.com', @sender.envelope_from
    @sender.logger = []
    assert_equal [], @sender.logger
    @sender.delay = 1
    assert_equal 1, @sender.delay
  end

  def test_send_with_no_recipients
    @mailing.expect(:recipients, [])
    @sender.send(@mailing)
    @mail.verify
    @mailing.verify
  end

  def test_send_with_recipients
    @sender.delay = 0
    @mailing.expect(:recipients, [1, 2])
    @mail.expect(:'to=', nil, [1])
    @mail.expect(:'to=', nil, [2])
    @channel.expect(:deliver, 'delivered', [String, 'me@host.com', 1])
    @channel.expect(:deliver, 'delivered', [String, 'me@host.com', 2])
    @sender.send(@mailing)
    @mail.verify
    @mailing.verify
    @channel.verify
  end
end
