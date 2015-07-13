defmodule AwesomeCli.Mixfile do
  use Mix.Project

  def project do
    [app: :awesome_cli,
     version: "0.0.1",
     elixir: "~> 1.0.4",
     escript: escript,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [ applications: [],
      mod: { AwesomeCli, [] } ]
  end

  # List all dependencies in the format:
  #
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    []
  end

  # Configuration for the escript build process
  #
  # Type `mix help escript.build` for more information
  defp escript do
    [ main_module: AwesomeCli,
      embedd_elixir: true ]
  end

end
