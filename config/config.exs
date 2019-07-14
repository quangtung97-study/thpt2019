use Mix.Config

config :thpt2019, Thpt2019.Repo,
  database: "thpt2019_repo",
  username: "postgres",
  password: "quangtung97",
  hostname: "localhost",
  pool_size: 20

config :thpt2019, ecto_repos: [Thpt2019.Repo]
