defmodule JumperTest do
  use ExUnit.Case
  doctest Jumper

  # compiled from various other libraries
  test_cases = [
    {0, 1, 0},
    {3, 1, 0},
    {0, 2, 0},
    {4, 2, 1},
    {7, 2, 0},
    {1, 1, 0},
    {42, 57, 43},
    {1, 128, 55},
    {129, 128, 120},
    {256, 1024, 520},
    {0xDEAD10CC, 1, 0},
    {0xDEAD10CC, 666, 361},
    {128, 100_000_000, 38_172_097},
    {128, 2_147_483_648, 1_644_467_860},
    {18_446_744_073_709_551_615, 128, 92},
    {0xA9993E364706816ABA3E25717850C26C9CD0D89D, 5, 2}
  ]

  # create a test cases for all defined above
  for {key, slots, expected} <- test_cases do
    test "slot(#{key}, #{slots}) == #{expected}" do
      assert Jumper.slot(unquote(key), unquote(slots)) == unquote(expected)
    end
  end

  test "negative buckets" do
    assert Jumper.slot(0, -10) == -1
  end
end
