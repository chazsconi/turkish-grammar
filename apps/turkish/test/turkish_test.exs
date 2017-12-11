defmodule TurkishTest do
  use ExUnit.Case
  import Turkish
  # doctest Turkish

  test "to_be with 'u' vowel harmony" do
    # tired
    assert "yorgunum" == to_be("yorgun", 1)
    assert "yorgunsun" == to_be("yorgun", 2)
    assert "yorgun" == to_be("yorgun", 3)
    assert "yorgunuz" == to_be("yorgun", 4)
    assert "yorgunsunuz" == to_be("yorgun", 5)
    assert "yorgunlar" == to_be("yorgun", 6)

    # full
    assert "tokum" == to_be("tok", 1)
    assert "toksun" == to_be("tok", 2)
    assert "tok" == to_be("tok", 3)
    assert "tokuz" == to_be("tok", 4)
    assert "toksunuz" == to_be("tok", 5)
    assert "toklar" == to_be("tok", 6)
  end

  test "to_be with 'ü' vowel harmony" do
    # sad
    assert "üzgünüm" == to_be("üzgün", 1)
    assert "üzgünsün" == to_be("üzgün", 2)
    assert "üzgün" == to_be("üzgün", 3)
    assert "üzgünüz" == to_be("üzgün", 4)
    assert "üzgünsünüz" == to_be("üzgün", 5)
    assert "üzgünler" == to_be("üzgün", 6)
  end

  test "to_be when ends in a vowel 1st person" do
    # sick
    assert "hastayım" == to_be("hasta", 1)
    # lucky
    assert "şanslıyım" == to_be("şanslı", 1)
  end

  test "to_be when ends in a vowel 1st person plural" do
    # sick
    assert "hastayız" == to_be("hasta", 4)
  end

  test "to_be when ends in a vowel 2nd person" do
    assert "hastasın" == to_be("hasta", 2)
    assert "şanslısın" == to_be("şanslı", 2)
  end

  test "noun_to_accusative" do
    assert "evi" == noun_to_accusative("ev")
    assert "sokağı" == noun_to_accusative("sokak")
    assert "gülü" == noun_to_accusative("gül")
    assert "kediyi" == noun_to_accusative("kedi")
    assert "bankayı" == noun_to_accusative("banka")
    assert "kutuyu" == noun_to_accusative("kutu")
  end

  test "noun_to_dative" do
    assert "eve" == noun_to_dative("ev")
    assert "sokağa" == noun_to_dative("sokak")
    assert "güle" == noun_to_dative("gül")
    assert "kediye" == noun_to_dative("kedi")
    assert "bankaya" == noun_to_dative("banka")
    assert "kutuya" == noun_to_dative("kutu")
  end

  test "noun_to_locative" do
    assert "evde" == noun_to_locative("ev")
    assert "okulda" == noun_to_locative("okul")
    assert "sokakta" == noun_to_locative("sokak")
  end

  test "noun_to_ablative" do
    assert "evden" == noun_to_ablative("ev")
    assert "okuldan" == noun_to_ablative("okul")
    assert "sokaktan" == noun_to_ablative("sokak")
  end

  test "noun_to_adjective" do
    assert "şanslı" == noun_to_adjective("şans")
    assert "bahtlı" == noun_to_adjective("baht") # luck
    assert "güllü" == noun_to_adjective("gül") # rose
  end

  test "adjective_to_noun" do
    assert "güzellik" == adjective_to_noun("güzel") # beautiful
    assert "mutluluk" == adjective_to_noun("mutlu") # happy
    assert "zorluk" == adjective_to_noun("zor") # difficulty
  end

  test "weaken_final_consonant" do
    assert "kuş" == weaken_final_consonant("kuş", "u") # bird
    assert "köpeğ" == weaken_final_consonant("köpek","i") # dog
    assert "köpek" == weaken_final_consonant("köpek","le") # dog
    assert "kebab" == weaken_final_consonant("kebap","ı")
    assert "ağac" == weaken_final_consonant("ağaç", "ı") # tree
    assert "halad" == weaken_final_consonant("halat", "ı") # rope
  end

  test "pluralise" do
    assert "köpekler" == pluralise("köpek") # dog
    assert "çocuklar" == pluralise("çocuk") # child
    assert "kediler" == pluralise("kedi") # cat
  end

  test "possessive suffix" do
    assert "kedim" == possessive("kedi",1) # cat
    assert "kedisi" == possessive("kedi",3)
    assert "kedileri" == possessive("kedi",6)
    assert "elim" == possessive("el", 1) # hand
    assert "eli" == possessive("el", 3)
    assert "ellerim" == possessive("eller", 1)
    assert "sokağım" == possessive("sokak", 1) # street
  end

  test "multiple suffixes" do
    assert "babacığım" == "baba" |> add_suffix("cık") |> add_suffix("ım") |> join_suffixes
  end
end
