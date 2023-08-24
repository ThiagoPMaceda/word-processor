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

  describe "POST api/replace [:replace]" do
    test "Replace a given substring with another string of characters." do
      params = %{
        text: "drink juice",
        substring: "juice",
        text_to_replace: "soda"
      }

      conn = post(build_conn(), "/api/replace", params)
      response = json_response(conn, 200)

      assert response == %{"word" => "drink soda"}
    end
  end

  describe "POST api/search [:search]" do
    test "Find the first occurrence of a given substring in the text." do
      params = %{
        text: "occurence first second first",
        substring: "first"
      }

      conn = post(build_conn(), "/api/search", params)
      response = json_response(conn, 200)

      assert response == %{"index" => 10}
    end

    test "return -1 if substring is not found in given text." do
      params = %{
        text: "word",
        substring: "not found"
      }

      conn = post(build_conn(), "/api/search", params)
      response = json_response(conn, 200)

      assert response == %{"index" => -1}
    end
  end
end
