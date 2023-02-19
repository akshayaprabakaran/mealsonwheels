defmodule MealsOnWheels.Parser.MONSupervisor do
  alias MealsOnWheels.Parser

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    children = [
      {Task.Supervisor, name: Parser.TaskSupervisor}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
