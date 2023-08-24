defmodule ShopnomixWeb.WordProcessorController do
  use ShopnomixWeb, :controller

  alias Shopnomix.WordProcessor

  def insert(conn, %{"text" => text, "text_to_insert" => text_to_insert, "position" => position}) do
    with word <- WordProcessor.insert(text, text_to_insert, position) do
      render(conn, :insert, word: word)
    end
  end
end
