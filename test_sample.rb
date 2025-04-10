require 'test/unit'
require "./sample"

class SampleTest < Test::Unit::TestCase
  def test_str_valid
    assert_equal(true, str_valid("a"))
  end

  def test_str_valid_uppercase
    assert_equal(true, str_valid("A"))
  end

  def test_str_not_valid_many_words
    assert_equal(false, str_valid("ab"))
  end

  def test_str_not_valid_not_alphabet
    assert_equal(false, str_valid("1"))
  end

  def test_str_not_valid_no_words
    assert_equal(false, str_valid(""))
  end
end
