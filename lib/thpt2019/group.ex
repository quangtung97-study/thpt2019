defmodule Thpt2019.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field(:name, :string)
    timestamps()
  end

  def changeset(%__MODULE__{} = group, params) do
    group
    |> cast(params, [:group])
    |> validate_required([:group])
  end
end
