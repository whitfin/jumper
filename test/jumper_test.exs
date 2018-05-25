defmodule JumperTest do
  use ExUnit.Case
  doctest Jumper

  test "slot(1, 1)" do
    assert Jumper.slot(1, 1) == 0
  end

  test "slot(42, 57)" do
    assert Jumper.slot(42, 57) == 43
  end

  test "slot(0xDEAD10CC, 1)" do
    assert Jumper.slot(0xDEAD10CC, 1) == 0
  end

  test "slot(0xDEAD10CC, 666)" do
    assert Jumper.slot(0xDEAD10CC, 666) == 361
  end

  test "slot(256, 1024)" do
    assert Jumper.slot(256, 1024) == 520
  end

  test "slot(0xA9993E364706816ABA3E25717850C26C9CD0D89D, 5)" do
    assert Jumper.slot(0xA9993E364706816ABA3E25717850C26C9CD0D89D, 5) == 2
  end

  test "negative buckets" do
    assert Jumper.slot(0, -10) == -1
  end
end
