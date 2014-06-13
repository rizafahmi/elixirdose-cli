# Create Command Line Tools

As software developers, we tend to depend on command line, especially me. Command line interface (CLI) are on fire this current time. Python, Ruby, Erlang and Elixir provide us with awesome tools on command line.  

So in this article we will attempt to creating a command line tools. And I have feeling that Elixir will do great in this area.

## Setting Up The Application

Let’s start with a new project using mix.

    $> mix new awesome_cli
    $> cd awesome_cli

Open up `lib/awesome_cli.ex` and you’ll see something like this:

    defmodule AwesomeCli do
      use Application.Behaviour

      # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
      # for more information on OTP Applications
      def start(_type, _args) do
        AwesomeCli.Supervisor.start_link
      end
    end

Let's do me a favor to create hello world message in the project, will you?!

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

Now run `mix escriptize` to make it executeable.

    $> mix escriptize

If you get error like: `** (Mix) Could not generate escript, please set :escript_main_module in your project configuration to a module that implements main/1` that mean you run Elixir version 0.14. According to changelog, Elixir version 0.14 changelog, it now require `:escript_main_module` to be set before generating escripts. So let's do that by opening `mix.exs` file.

    defmodule AwesomeCli.Mixfile do
      use Mix.Project

      def project do
        [app: :awesome_cli,
        version: "0.0.1",
        elixir: "~> 0.13.0",
        escript_main_module: :awesome_cli,
        deps: deps]
      end

      def application do
        [ applications: [],
          mod: { AwesomeCli, [] } ]
      end

      defp deps do
        []
      end
    end


