require 'test/unit'
require "./sample"

class SampleTest < Test::Unit::TestCase

  # str_validに関するテスト
  def test_str_valid
    assert_equal(true, str_valid("a", false))
  end

  def test_str_valid_uppercase
    assert_equal(true, str_valid("A", false))
  end

  def test_str_valid_hiragana
    assert_equal(true, str_valid("あ", true))
  end

  def test_str_valid_lowercase_hiragana
    assert_equal(true, str_valid("ぁ", true))
  end

  def test_str_valid_many_words_invalid
    assert_equal(false, str_valid("ab", false))
  end

  def test_str_valid_number_invalid
    assert_equal(false, str_valid("1", false))
  end

  def test_str_valid_no_words_invalid
    assert_equal(false, str_valid("", false))
  end

  # version_selectに関するテスト
  def test_version_select
    assert_equal(false, version_select("y"))
  end

  def test_version_select_invalid
    assert_equal(true, version_select("無効な場合"))
  end

  # mode_selectに関するテスト
  def test_mode_select_easy
    mode_flg, words, try_count = mode_select("easy", false, false)
    assert_equal(true, mode_flg)
    assert_equal(EASY_WORDS, words)
    assert_equal(10, try_count)
  end

  def test_mode_select_easy_hiragana
    mode_flg, words, try_count = mode_select("easy", false, true)
    assert_equal(true, mode_flg)
    assert_equal(EASY_HIRAGANA_WORDS, words)
    assert_equal(10, try_count)
  end

  def test_mode_select_normal
    mode_flg, words, try_count = mode_select("normal", false, false)
    assert_equal(true, mode_flg)
    assert_equal(NORMAL_WORDS, words)
    assert_equal(8, try_count)
  end

  def test_mode_select_normal_hiragana
    mode_flg, words, try_count = mode_select("normal", false, true)
    assert_equal(true, mode_flg)
    assert_equal(NORMAL_HIRAGANA_WORDS, words)
    assert_equal(8, try_count)
  end

  def test_mode_select_hard
    mode_flg, words, try_count = mode_select("hard", false, false)
    assert_equal(true, mode_flg)
    assert_equal(HARD_WORDS, words)
    assert_equal(5, try_count)
  end

  def test_mode_select_hard_hiragana
    mode_flg, words, try_count = mode_select("hard", false, true)
    assert_equal(true, mode_flg)
    assert_equal(HARD_HIRAGANA_WORDS, words)
    assert_equal(5, try_count)
  end

  def test_mode_select_invalid
    mode_flg, words, try_count = mode_select("無効な場合", false, false)
    assert_equal(false, mode_flg)
    assert_nil(words)
    assert_nil(try_count)
  end

end
