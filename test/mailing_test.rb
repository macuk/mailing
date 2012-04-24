# encoding: utf-8
require 'minitest/autorun'
require 'mailing/mailing'

class MailingTest < MiniTest::Unit::TestCase
  def setup
    @mailing = Mailing::Mailing.new('from', 'subject', 'body')
  end

  def test_init
    assert_equal 'from', @mailing.from
    assert_equal 'subject', @mailing.subject
    assert_equal 'body', @mailing.body
    assert_empty @mailing.recipients
  end

  def test_init_with_recipients
    @mailing = Mailing::Mailing.new('from', 'subject', 'body', [1, 2, 3])
    assert_equal [1, 2, 3], @mailing.recipients
  end

  def test_accessors
    @mailing.from = 'test'
    assert_equal 'test', @mailing.from
    @mailing.subject = 'test'
    assert_equal 'test', @mailing.subject
    @mailing.body = 'test'
    assert_equal 'test', @mailing.body
  end

  def test_recipient_accessor
    @mailing.recipients = [1, 2, 3]
    assert_equal 3, @mailing.recipients.size
    @mailing.recipients << 4
    assert_equal 4, @mailing.recipients.size
  end

  def test_mail
    mail = @mailing.mail.encoded
    assert_match /From: from/, mail
    assert_match /Subject: subject/, mail
    assert_match /body/, mail
  end

  def test_mail_with_encoding
    mailing = Mailing::Mailing.new('Żółw <zolw@domain.com>', 'Żółć', 'korzyść')
    mail = mailing.mail.encoded
    assert_match 'charset=UTF-8', mail
    assert_match 'From: =?UTF-8?B?xbvDs8WCdw==?= <zolw@domain.com>', mail
    assert_match 'Subject: =?UTF-8?Q?=C5=BB=C3=B3=C5=82=C4=87?=', mail
    assert_match 'a29yennFm8SH', mail
  end

  def test_send
    sender = MiniTest::Mock.new
    sender.expect(:send, nil, [@mailing])
    @mailing.send(sender)
    sender.verify
  end
end
