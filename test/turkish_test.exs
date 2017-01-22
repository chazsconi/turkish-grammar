defmodule TurkishTest do
  use ExUnit.Case
  import Turkish
  # doctest Turkish

  test "to_be with 'u' vowel harmony" do
    assert "yorgunum" == to_be("yorgun", 1)
    assert "yorgunsun" == to_be("yorgun", 2)
    assert "yorgun" == to_be("yorgun", 3)
    assert "yorgunuz" == to_be("yorgun", 4)
    assert "yorgunsunuz" == to_be("yorgun", 5)
    assert "yorgunlar" == to_be("yorgun", 6)

    assert "tokum" == to_be("tok", 1)
    assert "toksun" == to_be("tok", 2)
    assert "tok" == to_be("tok", 3)
    assert "tokuz" == to_be("tok", 4)
    assert "toksunuz" == to_be("tok", 5)
    assert "toklar" == to_be("tok", 6)
  end

  test "to_be with 'ü' vowel harmony" do
    assert "üzgünüm" == to_be("üzgün", 1)
    assert "üzgünsün" == to_be("üzgün", 2)
    assert "üzgün" == to_be("üzgün", 3)
    assert "üzgünüz" == to_be("üzgün", 4)
    assert "üzgünsünüz" == to_be("üzgün", 5)
    assert "üzgünler" == to_be("üzgün", 6)
  end

  test "to_be when ends in a vowel 1st person" do
    assert "hastayım" == to_be("hasta", 1)
    assert "şanslıyım" == to_be("şanslı", 1)
  end

  test "to_be when ends in a vowel 1st person plural" do
    assert "hastayız" == to_be("hasta", 4)
  end

  test "to_be when ends in a vowel 2nd person" do
    assert "hastasın" == to_be("hasta", 2)
    assert "şanslısın" == to_be("şanslı", 2)
  end
end
