defmodule AwesomeCli do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    AwesomeCli.Supervisor.start_link
  end

  def main(args) do
  	IO.puts "Hello, world!"
  end
 end
