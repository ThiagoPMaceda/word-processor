defmodule Shopnomix.WordProcessorTest do
  use ExUnit.Case

  alias Shopnomix.WordProcessor

  describe "insert" do
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
  end

  describe "delete" do
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

  describe "replace" do
    test "replaces text with specified text" do
      replaced_text = WordProcessor.replace("water juice", "water", "orange")
      assert replaced_text == "orange juice"
    end

    test "concurrent replacements" do
      concurrent_replacements = [
        Task.async(fn -> WordProcessor.replace("I like sunny days", "sunny", "rainy") end),
        Task.async(fn -> WordProcessor.replace("Drink soda", "soda", "water") end)
      ]

      results = Enum.map(concurrent_replacements, fn task -> Task.await(task) end)

      assert results == ["I like rainy days", "Drink water"]
    end
  end

  describe "search" do
    test "returns index if substring is found in index." do
      index = WordProcessor.search("firstssts", "sts")
      assert index == 3
    end

    test "returns -1 if substring is not found." do
      index = WordProcessor.search("firstssts", "not found")
      assert index == -1
    end

    test "concurrent searches" do
      concurrent_searches = [
        Task.async(fn -> WordProcessor.search("search pattern search pattern", "pattern") end),
        Task.async(fn -> WordProcessor.search("red blue yellow blue", "blue") end),
        Task.async(fn -> WordProcessor.search("not", "found") end)
      ]

      results = Enum.map(concurrent_searches, fn task -> Task.await(task) end)

      assert results == [7, 4, -1]
    end
  end
end
