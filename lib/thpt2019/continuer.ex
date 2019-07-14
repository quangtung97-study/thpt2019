defmodule Thpt2019.Continuer do
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def stop() do
    GenServer.stop(__MODULE__)
  end

  @impl true
  def init(_args) do
    {:ok, 0}
  end

  def reset() do
    GenServer.call(__MODULE__, :reset)
  end

  def failed() do
    GenServer.call(__MODULE__, :failed)
  end

  def get_counter() do
    GenServer.call(__MODULE__, :get_counter)
  end

  @impl true
  def handle_call(:get_counter, _from, counter) do
    {:reply, counter, counter}
  end

  @impl true
  def handle_call(:reset, _from, _counter) do
    {:reply, nil, 0}
  end

  @impl true
  def handle_call(:failed, _from, counter) do
    {:reply, nil, counter + 1}
  end
end
