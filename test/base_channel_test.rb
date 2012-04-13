require 'minitest/autorun'
require 'mailing/base_channel'

class BaseChannelTest < MiniTest::Unit::TestCase
  def setup
    @channel = Mailing::BaseChannel.new('config')
  end

  def test_config
    assert_equal 'config', @channel.config
    @channel.config = 'test'
    assert_equal 'test', @channel.config
  end

  def test_methods
    assert_nil @channel.start
    assert_nil @channel.deliver('mail', 'envelope_from', 'recipient')
    assert_nil @channel.finish
  end
end
