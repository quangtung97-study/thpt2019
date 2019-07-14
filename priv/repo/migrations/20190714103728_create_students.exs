defmodule Thpt2019.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :sbd, :integer

      add :toan, :decimal
      add :nguvan, :decimal
      add :ngoaingu, :decimal

      add :vatly, :decimal
      add :hoahoc, :decimal
      add :sinhhoc, :decimal

      add :lichsu, :decimal
      add :dialy, :decimal
      add :gdcd, :decimal
    end

    create unique_index(:students, [:sbd])
  end
end
