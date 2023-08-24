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
end
