defmodule ShopnomixWeb.WordProcessorControllerTest do
  use ExUnit.Case
  import Phoenix.ConnTest

  @endpoint ShopnomixWeb.Endpoint

  describe "POST api/insert [:insert]" do
    test "Insert a given string of characters at a specified position in the text." do
      params = %{text: "word challenge", text_to_insert: "processor ", position: 5}
      conn = post(build_conn(), "/api/insert", params)
      response = json_response(conn, 200)

      assert response == %{"word" => "word processor challenge"}
    end
  end

  describe "POST api/delete [:delete]" do
    test "Delete a specified range of characters from the text." do
      params = %{text: "Lionel texttoberemoved Messi", start_position: 8, end_position: 23}
      conn = post(build_conn(), "/api/delete", params)
      response = json_response(conn, 200)

      assert response == %{"word" => "Lionel Messi"}
    end
  end
end
