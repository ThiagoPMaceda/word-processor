defmodule Shopnomix.WordProcessorTest do
  use ExUnit.Case

  alias Shopnomix.WordProcessor

  test "inserts text at the specified position" do
    inserted_text = WordProcessor.insert("Hello, world!", "beautiful ", 7)
    assert inserted_text == "Hello, beautiful world!"
  end

  test "concurrent inserts" do
    concurrent_inserts = [
      Task.async(fn -> WordProcessor.insert("Hello, world!", "beautiful ", 7) end),
      Task.async(fn -> WordProcessor.insert("Welcome to Elixir", "amazing ", 11) end)
    ]

    results = Enum.map(concurrent_inserts, fn task -> Task.await(task) end)

    assert results == ["Hello, beautiful world!", "Welcome to amazing Elixir"]
  end

  test "deletes text at the specified range" do
    deleted_text = WordProcessor.delete("appdeletele", 4, 9)
    assert deleted_text == "apple"
  end

  test "concurrent deletions" do
    concurrent_deletions = [
      Task.async(fn -> WordProcessor.delete("orblueange", 3, 6) end),
      Task.async(fn -> WordProcessor.delete("airpcarlane", 5, 7) end)
    ]

    results = Enum.map(concurrent_deletions, fn task -> Task.await(task) end)

    assert results == ["orange", "airplane"]
  end
end
