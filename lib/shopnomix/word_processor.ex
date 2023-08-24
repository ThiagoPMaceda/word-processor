defmodule Shopnomix.WordProcessor do
  use GenServer

  def start_link(_opts \\ []) do
    case GenServer.start_link(__MODULE__, [], name: __MODULE__) do
      {:ok, server} ->
        {:ok, server}

      error ->
        error
    end
  end

  @spec insert(text :: String.t(), text_to_insert :: String.t(), position :: non_neg_integer()) ::
          {:ok, String.t()}
  def insert(text, text_to_insert, position) do
    GenServer.call(__MODULE__, {:insert, text, text_to_insert, position})
  end

  @impl true
  def init(args) do
    {:ok, args}
  end

  @impl true
  def handle_call({:insert, text, text_to_insert, position}, _from, state) do
    {splitted_text_first_part, splitted_text_second_part} = String.split_at(text, position)
    inserted_text = splitted_text_first_part <> text_to_insert <> splitted_text_second_part

    {:reply, inserted_text, state}
  end
end
