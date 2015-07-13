defmodule AwesomeCli do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    AwesomeCli.Supervisor.start_link
  end

  def main(args) do
    args |> parse_args |> do_process
  end

  def parse_args(args) do
    options = OptionParser.parse(args)

    case options do
      {[name: name], _, _} -> [name]
      {[help: true], _, _} -> :help
      _ -> :help

    end
  end

  def do_process([name]) do
    IO.puts "Hello, #{name}! You're awesome!!"
  end

  def do_process(:help) do
    IO.puts """
      Usage:
      ./awesome_cli --name [your name]

      Options:
      --help  Show this help message.

      Description:
      Prints out an awesome message.
    """

    System.halt(0)
  end
 end
