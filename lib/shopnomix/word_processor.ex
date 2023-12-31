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

  @spec delete(
          text :: String.t(),
          start_position :: non_neg_integer(),
          end_range :: non_neg_integer()
        ) ::
          {:ok, String.t()}
  def delete(text, start_position, end_position) do
    GenServer.call(__MODULE__, {:delete, text, start_position, end_position})
  end

  @spec replace(
          text :: String.t(),
          text_to_be_replace :: String.t(),
          text_to_replace_with :: String.t()
        ) ::
          {:ok, String.t()}
  def replace(text, text_to_be_replaced, text_to_replace_with) do
    GenServer.call(__MODULE__, {:replace, text, text_to_be_replaced, text_to_replace_with})
  end

  @spec search(
          text :: String.t(),
          substring :: String.t()
        ) ::
          {:ok, Int.t()}
  def search(text, substring) do
    GenServer.call(__MODULE__, {:search, text, substring})
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

  @impl true
  def handle_call({:delete, text, start_position, end_position}, _from, state) do
    deleted_text =
      String.slice(text, 0, start_position - 1) <>
        String.slice(text, end_position, String.length(text) - 1)

    {:reply, deleted_text, state}
  end

  @impl true
  def handle_call({:replace, text, text_to_be_replaced, text_to_replace_with}, _from, state) do
    replaced_text = String.replace(text, text_to_be_replaced, text_to_replace_with)

    {:reply, replaced_text, state}
  end

  @impl true
  def handle_call({:search, text, substring}, _from, state) do
    case String.contains?(text, substring) do
      true ->
        splitted_string = String.split(text, substring)
        index = String.length(List.first(splitted_string))

        {:reply, index, state}

      false ->
        {:reply, -1, state}
    end
  end
end
