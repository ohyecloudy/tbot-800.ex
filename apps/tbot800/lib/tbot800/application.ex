defmodule Tbot800.Application do
  use Application

  def start(_type, _args) do
    children = [
      Tbot800.DefaultImpl
    ]

    opts = [strategy: :one_for_one, name: Tbot800.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
