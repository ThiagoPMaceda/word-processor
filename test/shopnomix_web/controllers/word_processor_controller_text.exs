defmodule ShopnomixWeb.WordProcessorControllerTest do
  use ExUnit.Case
  import Phoenix.ConnTest

  @endpoint ShopnomixWeb.Endpoint

  describe "POST api/word_processor [:insert]" do
    test "Insert a given string of characters at a specified position in the text." do
      params = %{text: "word challenge", text_to_insert: "processor ", position: 5}
      conn = post(build_conn(), "/api/insert", params)
      response = json_response(conn, 200)

      assert response == %{"word" => "word processor challenge"}
    end
  end
end
