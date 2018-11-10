require_relative '../test_helpers'

class TestCommands < Minitest::Test

  def setup
    RocketRubyBot::Config.url = 'https://my.server/'
    @class = Class.new(RocketRubyBot::Commands)
  end

  def test_config
    assert_kind_of RocketRubyBot::Config, @class.config
  end

  def test_hooks
    assert @class.hooks.key? :ping
  end

  def test_on_event
    @class.on_event(:test) {}

    assert @class.hooks.key? :test
    assert_kind_of Array, @class.hooks[:test]
  end

  def test_setup
    value = false

    @class.setup { value = true }
    @class.hooks[:authenticated].first.call

    assert @class.hooks.key? :authenticated
    assert value
  end

  def test_closing
    value = false

    @class.closing { value = true }
    @class.hooks[:closing].first.call

    assert @class.hooks.key? :closing
    assert value
  end

  def teardown
    RocketRubyBot::Config.url = nil
    RocketRubyBot::Config.websocket_url = nil
  end
  
end
