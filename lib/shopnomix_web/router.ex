defmodule ShopnomixWeb.Router do
  use ShopnomixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ShopnomixWeb do
    pipe_through :api

    post("/insert", WordProcessorController, :insert)
    post("/delete", WordProcessorController, :delete)
  end
end
