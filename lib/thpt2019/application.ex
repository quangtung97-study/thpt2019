defmodule Thpt2019.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Thpt2019.Repo,
      Thpt2019.Continuer,
      Thpt2019.Supervisor
    ]

    opts = [strategy: :one_for_one, name: Thpt2019.RootSupervisor]
    Supervisor.start_link(children, opts)
  end
end
