defmodule Thpt2019.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    field(:sbd, :integer)

    field(:toan, :decimal)
    field(:nguvan, :decimal)
    field(:ngoaingu, :decimal)

    field(:vatly, :decimal)
    field(:hoahoc, :decimal)
    field(:sinhhoc, :decimal)

    field(:lichsu, :decimal)
    field(:dialy, :decimal)
    field(:gdcd, :decimal)
  end

  def changeset(%__MODULE__{} = student, params) do
    student
    |> cast(params, [
      :sbd,
      :toan,
      :nguvan,
      :ngoaingu,
      :vatly,
      :hoahoc,
      :sinhhoc,
      :lichsu,
      :dialy,
      :gdcd
    ])
    |> validate_required([:sbd])
    |> unique_constraint(:sbd)
  end
end
