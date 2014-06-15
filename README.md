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
        escript_main_module: AwesomeCli,
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

Let's rerun `mix escriptize` and mix will compile our awesome_cli.ex file and
generate a file `Elixir.AwesomeCli.beam` in the `_build/dev/lib/awesome_cli/ebin`
directory as well as one executable file called `awesome_cli`. Let's execute the file.

    $> ./awesome_cli
    Hello, world!

There you have it our first Elixir-powered executable application!

## Parsing Argument(s)

Lucky us, Elixir has [OptionParser](http://elixir-lang.org/docs/stable/elixir/OptionParser.html)
for parsing CLI argument(s). We will use this module to create an awesome command line tools that
will get an argument or two from user.

First thing first, we will create command line tools that will say hello to name we given.
We will do something like: `./awesome_cli --name ElixirFriend`.

Open up `lib/awesome_cli.ex` and add code below:

    def main(args) do
      args |> parse_args
    end

    def parse_args(args) do
      {[name: name], _, _} = OptionParser.parse(args)

      IO.puts "Hello, #{name}! You're awesome!!"
    end

We used `|>` operator to passing an argument to `parse_args` function. Then we used
`OptionParser.parse` to parse the argument, take exactly one argument then print it out.
Whe we run `mix escriptize` again then execute the app, we got something like this.

    $> mix escriptize
    $> ./awesome_cli --name ElixirFriend
    Hello, ElixirFriend! You're awesome!!

Awesome, right?! Ok, now to make our cli more awesome, let's implement help message to
guide user how to use this tool. Let's use `case` syntax to and pattern matching for this case.

    def parse_args(args) do
      options = OptionParser.parse(args)

      case options do
        {[name: name], _, _} -> IO.puts "Hello, #{name}! You're awesome!!"
        {[help: true], _, _} -> IO.puts "This is help message"

      end
    end

Rerun `mix escriptize` again and execute it with `--help` option.

    $> ./awesome_cli --name ElixirFriend
    Hello, ElixirFriend! You're awesome!!
    $> ./awesome_cli --help
    This is help message

## Finishing Touch

Let's refactor the code for little bit. First, we will make `parse_args` just for
parsing arguments and return something to be used in another function.

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

For the last time, rerun `mix escriptize` then try to execute it.

    $> mix escriptize
    $> ./awesome_cli --name ElixirFriend
    Hello, ElixirFriend! You're awesome!!
    $> ./awesome_cli --help
    Usage: 
    ./awesome_cli --name [your name]

    Options:
    --help  Show this help message.

    Description:
    Prints out an awesome message.
    $> ./awesome_cli
    Usage: 
    ./awesome_cli --name [your name]

    Options:
    --help  Show this help message.

    Description:
    Prints out an awesome message.

## Conclusion

Today we are using Elixir's `OptionParser` for creating a simple command line tools.
And with help from `mix escriptize` we able to generate the tools became executable.
This example maybe simple enough but with this we can take conclusion that very easy and feel natural to create command line tools with Elixir.


## References

* [How to create a command line utility with Elixir and mix](http://abstraction.killedthecat.net/create-command-line-utility-elixir-mix/)
* [OptionParser Docs](http://elixir-lang.org/docs/stable/elixir/OptionParser.html)
