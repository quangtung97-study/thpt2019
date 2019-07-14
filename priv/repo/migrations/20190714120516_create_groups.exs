defmodule Thpt2019.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :number, :integer
      add :name, :string
    end

    create unique_index(:groups, [:name])
  end
end
