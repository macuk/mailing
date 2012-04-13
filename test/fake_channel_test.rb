require 'minitest/autorun'
require 'mailing/fake_channel'

class FakeChannelTest < MiniTest::Unit::TestCase
  def setup
    @channel = Mailing::FakeChannel.new('config')
  end

  def test_deliver
    assert_equal 'Sent to recipient', @channel.deliver('mail', 'envelope_from', 'recipient')
  end
end
