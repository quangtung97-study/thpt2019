defmodule Thpt2019.Producer do
  use GenStage
  alias Thpt2019.Continuer

  @max_failed 2000

  def start_link(_args) do
    GenStage.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_args) do
    {:producer, %{group: 20, sbd_suffix: 1}}
  end

  @impl true
  def handle_demand(demand, state) do
    with %{group: group, sbd_suffix: sbd_suffix} <- state,
         true <- group <= 64 do
      if Continuer.get_counter() < @max_failed do
        a = sbd_suffix
        b = sbd_suffix + demand - 1

        sbd_list =
          a..b
          |> Enum.map(fn suffix -> suffix + group * 1_000_000 end)

        {:noreply, sbd_list, %{state | sbd_suffix: b}}
      else
        Continuer.reset()
        group = group + 1
        a = 1
        b = demand

        sbd_list =
          a..b
          |> Enum.map(fn suffix -> suffix + group * 1_000_000 end)

        {:noreply, sbd_list, %{group: group, sbd_suffix: b}}
      end
    else
      _ -> {:noreply, [], nil}
    end
  end
end
