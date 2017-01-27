defmodule Turkish do

  @vowels "aeiouüıö"

  @doc "Conjugates verb to be with an adjective"
  def to_be(adjective, person) do
    harmonies = vowel_harmonies(adjective)
    pp_suffix = pp_suffix(harmonies, person)
    joiner = joiner(adjective, pp_suffix)
    adjective <> joiner <> pp_suffix
  end

  def noun_to_accusative(noun) do
    {big_harmony, _} = vowel_harmonies(noun)
    suffix = big_harmony
    join_stem_and_suffix(noun, suffix)
  end

  def pluralise(noun) do
    {_, small_harmony} = vowel_harmonies(noun)
    noun <> "l" <> small_harmony <> "r"
  end

  def noun_to_dative(noun) do
    {_, small_harmony} = vowel_harmonies(noun)
    suffix = small_harmony
    join_stem_and_suffix(noun, suffix)
  end

  def join_stem_and_suffix(stem, suffix) do
    weaken_final_consonant(stem, suffix) <> joiner(stem, suffix) <> suffix
  end

  def weaken_final_consonant(noun, suffix) do
    if String.contains?(@vowels, String.first(suffix)) do
      {start, last} = String.split_at(noun, -1)
      case last do
        "p" -> start <> "b"
        "ç" -> start <> "c"
        "k" -> start <> "ğ"
        "t" -> start <> "d"
        _   -> noun
      end
    else
      noun
    end
  end

  def noun_to_adjective(noun) do
    {big_harmony, _} = vowel_harmonies(noun)
    noun <> "l" <> big_harmony
  end

  def adjective_to_noun(adjective) do
    {big_harmony, _} = vowel_harmonies(adjective)
    adjective <> "l" <> big_harmony <> "k"
  end

  @doc "Retuns the personal pronoun suffix"
  def pp_suffix({big_harmony, small_harmony}, person) do
    case person do
      1 -> big_harmony <> "m"
      2 -> "s" <> big_harmony <> "n"
      3 -> ""
      4 -> big_harmony <> "z"
      5 -> "s" <> big_harmony <> "n" <> big_harmony <> "z"
      6 -> "l" <> small_harmony <> "r"
    end
  end

  @doc "Gives the big and small harmonies of a word"
  def vowel_harmonies(word) do
    vowel =
      word
      |> last_vowel

    case vowel do
      "a" -> {"ı", "a"}
      "ı" -> {"ı", "a"}
      "o" -> {"u", "a"}
      "u" -> {"u", "a"}
      "e" -> {"i", "e"}
      "i" -> {"i", "e"}
      "ü" -> {"ü", "e"}
      "ö" -> {"ü", "e"}
    end
  end

  def last_vowel(word) do
    word
    |> vowels
    |> Enum.reverse
    |> hd
  end

  def vowels(word) do
    word
    |> String.graphemes
    |> Enum.filter(
      fn letter ->
        String.contains?(@vowels, letter)
      end)
  end

  @doc "Returns a joiner letter if required between a word and the suffixes"
  def joiner(word, suffix) do
    case String.contains?(@vowels, String.last(word)) &&
         String.contains?(@vowels, String.first(suffix)) do
      true -> "y"
      false -> ""
    end
  end
end
