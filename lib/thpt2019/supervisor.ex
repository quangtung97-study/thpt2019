defmodule Thpt2019.Supervisor do
  use Supervisor

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_args) do
    children = [
      Thpt2019.Producer,
      Supervisor.child_spec(Thpt2019.Consumer, id: :c1),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c2),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c3),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c4),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c5),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c6),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c7),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c8),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c9),
      Supervisor.child_spec(Thpt2019.Consumer, id: :c10)
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
