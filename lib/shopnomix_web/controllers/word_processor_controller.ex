defmodule ShopnomixWeb.WordProcessorController do
  use ShopnomixWeb, :controller

  alias Shopnomix.WordProcessor

  def insert(conn, %{"text" => text, "text_to_insert" => text_to_insert, "position" => position}) do
    with word <- WordProcessor.insert(text, text_to_insert, position) do
      render(conn, :show, word: word)
    end
  end

  def delete(conn, %{
        "text" => text,
        "start_position" => start_position,
        "end_position" => end_position
      }) do
    with word <- WordProcessor.delete(text, start_position, end_position) do
      render(conn, :show, word: word)
    end
  end

  def replace(conn, %{
        "text" => text,
        "substring" => substring,
        "text_to_replace" => text_to_replace
      }) do
    with word <- WordProcessor.replace(text, substring, text_to_replace) do
      render(conn, :show, word: word)
    end
  end

  def search(conn, %{"text" => text, "substring" => substring}) do
    with index <- WordProcessor.search(text, substring) do
      render(conn, :search, index: index)
    end
  end
end
