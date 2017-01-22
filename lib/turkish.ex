defmodule Turkish do

  @vowels "aeiouüıö"

  @doc "Conjugates verb to be with an adjective"
  def to_be(adjective, person) do
    harmonies = vowel_harmonies(adjective)
    pp_suffix = pp_suffix(harmonies, person)
    joiner = joiner(adjective, pp_suffix)
    adjective <> joiner <> pp_suffix
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
      "e" -> {"e", "e"}
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