defmodule Thpt2019.Consumer do
  use GenStage
  alias Thpt2019.{Student, Repo, Continuer}

  def start_link(_args) do
    GenStage.start_link(__MODULE__, [])
  end

  @impl true
  def init(_args) do
    producer = {
      Thpt2019.Producer,
      max_demand: 100, min_demand: 50
    }

    {:consumer, %{}, subscribe_to: [producer]}
  end

  defp to_changeset({params, sbd}) do
    {Student.changeset(%Student{}, params), sbd}
  end

  defp insert({changeset, sbd}) do
    time = DateTime.to_string(DateTime.utc_now())

    with {:ok, student} <- Repo.insert(changeset) do
      IO.puts("[#{time}] Student: #{inspect(student)}")
      Continuer.reset()
    else
      _ ->
        {sbd, _} = Thpt2019.sbd_to_strings(sbd)
        IO.puts("[#{time}] SBD: #{sbd} Failed")
        Continuer.failed()
    end
  end

  @impl true
  def handle_events(sbd_list, _from, _state) do
    sbd_list
    |> Stream.map(fn sbd ->
      {sbd |> Thpt2019.get() |> Thpt2019.parse(), sbd}
    end)
    |> Stream.map(&to_changeset/1)
    |> Enum.each(&insert/1)

    {:noreply, [], %{}}
  end
end
