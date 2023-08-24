defmodule ShopnomixWeb.WordProcessorJSON do
  def show(%{word: word}) do
    %{
      word: word
    }
  end

  def search(%{index: index}) do
    %{
      index: index
    }
  end
end
