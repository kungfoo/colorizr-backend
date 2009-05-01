require "test/unit"

require "colorizr_config"

class TestColorizrConfig < Test::Unit::TestCase
  def test_db_string
    c = ColorizrConfig.new
    assert_not_nil(c.instance_eval("@config"))
    assert_equal("db/mood10k.db", c.database)
  end
end