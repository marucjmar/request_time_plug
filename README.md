# RequestTimePlug

**Request Time plug**

Plug to get constant response time for requests. Simple protection against side channel attacks.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `request_time_plug` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:request_time_plug, "~> 0.1.0"}
  ]
end
```

```elixir
  defmodule MyAppWeb.Router do
    ...

    plug RequestTimePlug, request_time: 2000

    post "/pake_password_hash", Foo
  end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/request_time_plug](https://hexdocs.pm/request_time_plug).
