require 'test_helper'

class PrefNameTest < ActiveSupport::TestCase
  test "should get pref name" do
    assert_equal('北海道', PrefName.get_pref_name('1'))
    assert_equal('沖縄県', PrefName.get_pref_name('47'))
  end
end
