defmodule Turkish do

  @vowels "aeiouüıö"

  @doc "Conjugates verb to be with an adjective"
  def to_be(adjective, person) do
    adjective
    |> add_suffix(pp_suffix(person))
    |> join_suffixes
  end

  @doc "Retuns the personal pronoun suffix"
  def pp_suffix(person) do
    case person do
      1 -> "ım"
      2 -> "sın"
      3 -> ""
      4 -> "ız"
      5 -> "sınız"
      6 -> "lar"
    end
  end

  def possessive(noun, person) do
    noun
    |> add_suffix(possessive_suffix(person))
    |> join_suffixes
  end

  def possessive_suffix(person) do
    case person do
      # consonant suffix, vowel suffix
      1 -> {"ım", "m"}
      2 -> {"ın", "n"}
      3 -> {"ı", "sı"}
      4 -> {"ımız", "mız"}
      5 -> {"ınız", "nız"}
      6 -> "ları"
    end
  end

  def noun_to_accusative(noun) do
    noun
    |> add_suffix("ı")
    |> join_suffixes
  end

  def noun_to_dative(noun) do
    noun
    |> add_suffix("a")
    |> join_suffixes
  end

  def pluralise(noun) do
    noun
    |> add_suffix("lar")
    |> join_suffixes
  end

  def noun_to_adjective(noun) do
    noun
    |> add_suffix("lı")
    |> join_suffixes
  end

  def adjective_to_noun(adjective) do
    adjective
    |> add_suffix("lık")
    |> join_suffixes
  end


  def add_suffix({stem, suffixes}, ""), do: {stem, suffixes}
  def add_suffix({stem, suffixes}, suffix), do: {stem, suffixes ++ [suffix]}
  def add_suffix(stem, suffix), do: add_suffix({stem, []}, suffix)

  def join_suffixes({stem, suffixes}), do: join_suffixes(stem, suffixes, true)

  def join_suffixes(word, [], _first?), do: word
  def join_suffixes(word, [suffix | suffixes], first?) do
    {big_harmony, small_harmony} = vowel_harmonies(word)

    suffix
    |> choose_suffix(word)
    |> String.replace("ı", big_harmony)
    |> String.replace("a", small_harmony)
    |> join_suffix_to_word(word, first?)
    |> join_suffixes(suffixes, false)
  end

  @doc "If a consonant and vowel suffix are supplied chose the right one based on the last letter of the word"
  def choose_suffix({consonant_suffix, vowel_suffix}, word) do
    if String.contains?(@vowels, String.last(word)) do
      vowel_suffix
    else
      consonant_suffix
    end
  end
  def choose_suffix(suffix, _word), do: suffix

  def join_suffix_to_word(suffix, word, _first?) do
    weaken_final_consonant(word, suffix) <> joiner(word, suffix) <> suffix
  end

  def weaken_final_consonant(word, suffix) do
    if length(vowels(word)) > 1 and
       String.contains?(@vowels, String.first(suffix)) do
      {start, last} = String.split_at(word, -1)
      case last do
        "p" -> start <> "b"
        "ç" -> start <> "c"
        "k" -> start <> "ğ"
        "t" -> start <> "d"
        _   -> word
      end
    else
      word
    end
  end

  @doc "Gives the big (complex) and small (simple) harmonies of a word"
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
      "ö" -> {"ü", "e"}
      "ü" -> {"ü", "e"}
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
